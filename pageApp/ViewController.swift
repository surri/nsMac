//
//  ViewController.swift
//  pageApp
//
//  Created by E.Hyun on 2016. 2. 13..
//  Copyright © 2016년 NSMac. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate{
    
    var pageController : UIPageViewController?
    var pageContent = NSArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createContentPages()

        self.pageController = UIPageViewController(
            transitionStyle: .PageCurl,   //페이지 효과 .scroll 슬라이드
            navigationOrientation: .Horizontal,
            options: nil)
        
        self.pageController?.delegate = self
        self.pageController?.dataSource = self
        
        let startingViewController: ContentViewController =
        viewControllerAtIndex(0)!
        
        let viewControllers: NSArray = [startingViewController]
        self.pageController!.setViewControllers(viewControllers as? [UIViewController],
            direction: .Forward,
            animated: false,
            completion: nil)
        
        //페이지 뷰 추가
        self.addChildViewController(self.pageController!)
        self.view.addSubview(self.pageController!.view)
        
        let pageViewRect = self.view.bounds

        self.pageController!.didMoveToParentViewController(self)
    }
    
    
    func createContentPages(){ //배열에 html 삽입
        var pageStrings = [String]()
        
        for i in 1...11
        {
            let contentString = "<html><head></head><body><br><h1>Chapter \(i)</h1><p>This is the page \(i) of content displayed using UIPageViewController in iOS 9.</p></body></html>"
            pageStrings.append(contentString)
        }
        pageContent = pageStrings
    }
    
    func viewControllerAtIndex(index: Int) -> ContentViewController? {
        
        if (pageContent.count == 0) ||
            (index >= pageContent.count) {
            return nil
        }
        
        let storyBoard = UIStoryboard(name: "Main",
            bundle: NSBundle.mainBundle())
        let dataViewController = storyBoard.instantiateViewControllerWithIdentifier("contentView") as! ContentViewController
        
        dataViewController.dataObject = pageContent[index]
        return dataViewController
    }
    
    func indexOfViewController(viewController: ContentViewController) -> Int {
        
        if let dataObject: AnyObject = viewController.dataObject {
            return pageContent.indexOfObject(dataObject)
        } else {
            return NSNotFound
        }
    }
    
    //이전 컨트롤러
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        var index = indexOfViewController(viewController
            as! ContentViewController) //ContentViewController의 index
        
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index--
        return viewControllerAtIndex(index)
    }
    
    //다음 컨트롤러
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        var index = indexOfViewController(viewController
            as! ContentViewController)
        
        if index == NSNotFound {
            return nil
        }
        
        index++
        if index == pageContent.count {
            return nil
        }
        return viewControllerAtIndex(index)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

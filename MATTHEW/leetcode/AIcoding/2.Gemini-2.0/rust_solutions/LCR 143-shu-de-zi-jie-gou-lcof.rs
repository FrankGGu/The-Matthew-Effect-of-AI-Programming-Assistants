#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Rc<RefCell<TreeNode>>>,
    pub right: Option<Rc<RefCell<TreeNode>>>,
}

impl TreeNode {
    #[inline]
    pub fn new(val: i32) -> Self {
        TreeNode {
            val,
            left: None,
            right: None,
        }
    }
}

use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn is_sub_structure(a: Option<Rc<RefCell<TreeNode>>>, b: Option<Rc<RefCell<TreeNode>>>) -> bool {
        if b.is_none() {
            return false;
        }
        if a.is_none() {
            return false;
        }

        Solution::recur(a.clone(), b.clone()) || Solution::is_sub_structure(a.clone().unwrap().borrow().left.clone(), b.clone()) || Solution::is_sub_structure(a.unwrap().borrow().right.clone(), b)
    }

    fn recur(a: Option<Rc<RefCell<TreeNode>>>, b: Option<Rc<RefCell<TreeNode>>>) -> bool {
        if b.is_none() {
            return true;
        }
        if a.is_none() || a.clone().unwrap().borrow().val != b.clone().unwrap().borrow().val {
            return false;
        }

        Solution::recur(a.unwrap().borrow().left.clone(), b.clone().unwrap().borrow().left.clone()) && Solution::recur(a.unwrap().borrow().right.clone(), b.unwrap().borrow().right.clone())
    }
}

struct Solution;
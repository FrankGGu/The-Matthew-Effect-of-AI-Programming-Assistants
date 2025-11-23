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
    pub fn trim_bst(root: Option<Rc<RefCell<TreeNode>>>, low: i32, high: i32) -> Option<Rc<RefCell<TreeNode>>> {
        match root {
            None => None,
            Some(node) => {
                let val = node.borrow().val;
                if val < low {
                    Self::trim_bst(node.borrow().right.clone(), low, high)
                } else if val > high {
                    Self::trim_bst(node.borrow().left.clone(), low, high)
                } else {
                    let left = Self::trim_bst(node.borrow().left.clone(), low, high);
                    let right = Self::trim_bst(node.borrow().right.clone(), low, high);
                    node.borrow_mut().left = left;
                    node.borrow_mut().right = right;
                    Some(node)
                }
            }
        }
    }
}
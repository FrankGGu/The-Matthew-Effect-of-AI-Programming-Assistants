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
    pub fn search_bst(root: Option<Rc<RefCell<TreeNode>>>, val: i32) -> Option<Rc<RefCell<TreeNode>>> {
        match root {
            Some(node) => {
                let borrow = node.borrow();
                if borrow.val == val {
                    Some(node.clone())
                } else if val < borrow.val {
                    Solution::search_bst(borrow.left.clone(), val)
                } else {
                    Solution::search_bst(borrow.right.clone(), val)
                }
            }
            None => None,
        }
    }
}

struct Solution;
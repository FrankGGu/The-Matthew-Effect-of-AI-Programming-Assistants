impl Solution {

use std::cell::RefCell;
use std::rc::Rc;

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

pub fn find_tilt(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
    fn helper(node: &Option<Rc<RefCell<TreeNode>>>) -> (i32, i32) {
        if let Some(n) = node {
            let left = helper(&n.borrow().left);
            let right = helper(&n.borrow().right);
            let sum = left.0 + right.0 + n.borrow().val;
            let tilt = (left.0 - right.0).abs();
            (sum, left.1 + right.1 + tilt)
        } else {
            (0, 0)
        }
    }

    helper(&root).1
}
}
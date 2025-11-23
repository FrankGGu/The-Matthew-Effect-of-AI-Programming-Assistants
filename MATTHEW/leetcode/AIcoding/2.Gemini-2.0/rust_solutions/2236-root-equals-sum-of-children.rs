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
    pub fn check_tree(root: Option<Rc<RefCell<TreeNode>>>) -> bool {
        if let Some(node) = root {
            let node_ref = node.borrow();
            let left_val = node_ref.left.as_ref().map(|n| n.borrow().val).unwrap_or(0);
            let right_val = node_ref.right.as_ref().map(|n| n.borrow().val).unwrap_or(0);
            return node_ref.val == left_val + right_val;
        }
        false
    }
}

struct Solution;
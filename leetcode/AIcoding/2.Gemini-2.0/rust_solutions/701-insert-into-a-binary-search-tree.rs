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
    pub fn insert_into_bst(root: Option<Rc<RefCell<TreeNode>>>, val: i32) -> Option<Rc<RefCell<TreeNode>>> {
        match root {
            None => Some(Rc::new(RefCell::new(TreeNode::new(val)))),
            Some(node) => {
                let mut node_ref = node.borrow_mut();
                if val < node_ref.val {
                    node_ref.left = Solution::insert_into_bst(node_ref.left.take(), val);
                } else {
                    node_ref.right = Solution::insert_into_bst(node_ref.right.take(), val);
                }
                Some(Rc::new(RefCell::new(TreeNode {
                    val: node_ref.val,
                    left: node_ref.left.take(),
                    right: node_ref.right.take(),
                })))
            }
        }
    }
}

struct Solution;
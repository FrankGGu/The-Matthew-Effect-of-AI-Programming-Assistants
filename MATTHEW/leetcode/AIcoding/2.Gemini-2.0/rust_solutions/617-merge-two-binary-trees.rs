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
    pub fn merge_trees(root1: Option<Rc<RefCell<TreeNode>>>, root2: Option<Rc<RefCell<TreeNode>>>) -> Option<Rc<RefCell<TreeNode>>> {
        match (root1, root2) {
            (None, None) => None,
            (Some(r1), None) => Some(r1),
            (None, Some(r2)) => Some(r2),
            (Some(r1), Some(r2)) => {
                let mut node1 = r1.borrow_mut();
                let mut node2 = r2.borrow_mut();
                node1.val += node2.val;
                node1.left = Solution::merge_trees(node1.left.take(), node2.left.take());
                node1.right = Solution::merge_trees(node1.right.take(), node2.right.take());
                Some(Rc::new(RefCell::new(TreeNode {
                    val: node1.val,
                    left: node1.left.take(),
                    right: node1.right.take(),
                })))
            }
        }
    }
}

struct Solution;
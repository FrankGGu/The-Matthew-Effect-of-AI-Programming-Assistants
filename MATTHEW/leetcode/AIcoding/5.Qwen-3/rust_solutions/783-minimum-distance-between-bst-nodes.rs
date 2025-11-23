impl Solution {

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
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

pub struct Solution;

use std::cmp::min;
use std::cell::RefCell;
use std::rc::Rc;

impl Solution {
    pub fn min_diff_in_bst(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        let mut prev = None;
        let mut min_diff = i32::MAX;
        Solution::inorder_traversal(root, &mut prev, &mut min_diff);
        min_diff
    }

    fn inorder_traversal(
        root: Option<Rc<RefCell<TreeNode>>>,
        prev: &mut Option<i32>,
        min_diff: &mut i32,
    ) {
        if let Some(node) = root {
            Solution::inorder_traversal(node.borrow().left.clone(), prev, min_diff);
            if let Some(p) = *prev {
                *min_diff = min(*min_diff, node.borrow().val - p);
            }
            *prev = Some(node.borrow().val);
            Solution::inorder_traversal(node.borrow().right.clone(), prev, min_diff);
        }
    }
}
}
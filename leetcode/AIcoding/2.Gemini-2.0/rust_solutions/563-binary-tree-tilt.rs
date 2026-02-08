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
    pub fn find_tilt(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        let mut tilt_sum = 0;
        Self::calculate_tilt(&root, &mut tilt_sum);
        tilt_sum
    }

    fn calculate_tilt(node: &Option<Rc<RefCell<TreeNode>>>, tilt_sum: &mut i32) -> i32 {
        match node {
            Some(node_rc) => {
                let node = node_rc.borrow();
                let left_sum = Self::calculate_tilt(&node.left, tilt_sum);
                let right_sum = Self::calculate_tilt(&node.right, tilt_sum);
                *tilt_sum += (left_sum - right_sum).abs();
                node.val + left_sum + right_sum
            }
            None => 0,
        }
    }
}

struct Solution;
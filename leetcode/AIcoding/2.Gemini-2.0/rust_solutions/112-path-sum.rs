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
    pub fn has_path_sum(root: Option<Rc<RefCell<TreeNode>>>, target_sum: i32) -> bool {
        match root {
            Some(node) => {
                let node = node.borrow();
                let val = node.val;
                let left = &node.left;
                let right = &node.right;

                if left.is_none() && right.is_none() {
                    return val == target_sum;
                }

                let left_result = match left {
                    Some(left_node) => Solution::has_path_sum(Some(Rc::clone(left_node)), target_sum - val),
                    None => false,
                };

                let right_result = match right {
                    Some(right_node) => Solution::has_path_sum(Some(Rc::clone(right_node)), target_sum - val),
                    None => false,
                };

                left_result || right_result
            }
            None => false,
        }
    }
}
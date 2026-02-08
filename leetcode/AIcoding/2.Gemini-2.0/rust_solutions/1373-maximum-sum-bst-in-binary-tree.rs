use std::cell::RefCell;
use std::rc::Rc;

impl Solution {
    pub fn max_sum_bst(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        let mut max_sum = 0;
        fn dfs(node: Option<Rc<RefCell<TreeNode>>>, max_sum: &mut i32) -> (bool, i32, i32, i32) {
            if node.is_none() {
                return (true, i32::MAX, i32::MIN, 0);
            }
            let node_ref = node.as_ref().unwrap().borrow();
            let val = node_ref.val;
            let (left_bst, left_min, left_max, left_sum) = dfs(node_ref.left.clone(), max_sum);
            let (right_bst, right_min, right_max, right_sum) = dfs(node_ref.right.clone(), max_sum);

            if left_bst && right_bst && val as i32 > left_max && val as i32 < right_min {
                let sum = left_sum + right_sum + val as i32;
                *max_sum = (*max_sum).max(sum);
                return (true, left_min.min(val as i32), right_max.max(val as i32), sum);
            } else {
                return (false, i32::MIN, i32::MAX, 0);
            }
        }
        dfs(root, &mut max_sum);
        max_sum
    }
}

use std::cmp::{max, min};

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

struct Solution;
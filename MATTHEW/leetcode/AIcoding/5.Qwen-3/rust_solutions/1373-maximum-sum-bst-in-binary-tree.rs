impl Solution {

use std::rc::Rc;
use std::cell::RefCell;

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

pub fn max_sum_bst(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
    let mut max_sum = 0;
    dfs(root, &mut max_sum);
    max_sum
}

fn dfs(node: Option<Rc<RefCell<TreeNode>>>, max_sum: &mut i32) -> (bool, i32, i32, i32) {
    if let Some(n) = node {
        let node_ref = n.borrow();
        let (left_is_bst, left_min, left_max, left_sum) = dfs(node_ref.left.clone(), max_sum);
        let (right_is_bst, right_min, right_max, right_sum) = dfs(node_ref.right.clone(), max_sum);

        if left_is_bst && right_is_bst && node_ref.val > left_max && node_ref.val < right_min {
            let current_sum = left_sum + right_sum + node_ref.val;
            *max_sum = std::cmp::max(*max_sum, current_sum);
            let current_min = std::cmp::min(node_ref.val, left_min);
            let current_max = std::cmp::max(node_ref.val, right_max);
            (true, current_min, current_max, current_sum)
        } else {
            (false, 0, 0, 0)
        }
    } else {
        (true, i32::MAX, i32::MIN, 0)
    }
}
}
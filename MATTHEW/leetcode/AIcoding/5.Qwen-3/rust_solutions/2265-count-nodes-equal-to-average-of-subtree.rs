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

pub struct Solution {}

use std::cell::RefCell;
use std::rc::Rc;

impl Solution {
    pub fn average_of_subtree(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        let mut count = 0;
        Self::dfs(root, &mut count);
        count
    }

    fn dfs(node: Option<Rc<RefCell<TreeNode>>>, count: &mut i32) -> (i32, i32) {
        if let Some(n) = node {
            let node_ref = n.borrow();
            let (left_sum, left_count) = Self::dfs(node_ref.left.clone(), count);
            let (right_sum, right_count) = Self::dfs(node_ref.right.clone(), count);
            let total_sum = left_sum + right_sum + node_ref.val;
            let total_count = left_count + right_count + 1;
            if total_sum / total_count == node_ref.val {
                *count += 1;
            }
            (total_sum, total_count)
        } else {
            (0, 0)
        }
    }
}
}
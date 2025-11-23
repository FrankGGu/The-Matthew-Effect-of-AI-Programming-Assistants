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
      right: None
    }
  }
}

struct Solution;

impl Solution {
    pub fn max_path_sum(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        let mut max_sum = i32::MIN;
        Self::dfs(root, &mut max_sum);
        max_sum
    }

    fn dfs(node: Option<Rc<RefCell<TreeNode>>>, max_sum: &mut i32) -> i32 {
        if let Some(n) = node {
            let n_ref = n.borrow();

            let left_gain = Self::dfs(n_ref.left.clone(), max_sum).max(0);
            let right_gain = Self::dfs(n_ref.right.clone(), max_sum).max(0);

            let current_path_through_node = n_ref.val + left_gain + right_gain;
            *max_sum = (*max_sum).max(current_path_through_node);

            n_ref.val + left_gain.max(right_gain)
        } else {
            0
        }
    }
}
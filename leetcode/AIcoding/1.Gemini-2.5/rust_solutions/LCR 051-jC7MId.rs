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
        let mut max_so_far = i32::MIN;
        Self::dfs(&root, &mut max_so_far);
        max_so_far
    }

    fn dfs(node_opt: &Option<Rc<RefCell<TreeNode>>>, max_so_far: &mut i32) -> i32 {
        if let Some(node_rc) = node_opt {
            let node = node_rc.borrow();
            let node_val = node.val;

            let left_gain = Self::dfs(&node.left, max_so_far).max(0);
            let right_gain = Self::dfs(&node.right, max_so_far).max(0);

            let current_path_sum_through_node = node_val + left_gain + right_gain;
            *max_so_far = (*max_so_far).max(current_path_sum_through_node);

            node_val + left_gain.max(right_gain)
        } else {
            0
        }
    }
}
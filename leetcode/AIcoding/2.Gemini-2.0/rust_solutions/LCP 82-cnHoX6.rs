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

impl Solution {
    pub fn sufficient_subset(root: Option<Rc<RefCell<TreeNode>>>, limit: i32) -> Option<Rc<RefCell<TreeNode>>> {
        if let Some(node) = root.clone() {
            if Self::dfs(&node, 0, limit) {
                return root;
            } else {
                return None;
            }
        }
        None
    }

    fn dfs(node: &Rc<RefCell<TreeNode>>, current_sum: i32, limit: i32) -> bool {
        let mut node_ref = node.borrow_mut();
        let val = node_ref.val;

        if node_ref.left.is_none() && node_ref.right.is_none() {
            return current_sum + val >= limit;
        }

        let mut left_alive = false;
        if let Some(left) = node_ref.left.clone() {
            left_alive = Self::dfs(&left, current_sum + val, limit);
            if !left_alive {
                node_ref.left = None;
            }
        }

        let mut right_alive = false;
        if let Some(right) = node_ref.right.clone() {
            right_alive = Self::dfs(&right, current_sum + val, limit);
            if !right_alive {
                node_ref.right = None;
            }
        }

        left_alive || right_alive
    }
}

struct Solution;
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
    pub fn path_sum(root: Option<Rc<RefCell<TreeNode>>>, target_sum: i32) -> Vec<Vec<i32>> {
        let mut result: Vec<Vec<i32>> = Vec::new();
        let mut current_path: Vec<i32> = Vec::new();

        Self::dfs(root, &mut current_path, target_sum, &mut result);

        result
    }

    fn dfs(
        node: Option<Rc<RefCell<TreeNode>>>,
        current_path: &mut Vec<i32>,
        remaining_sum: i32,
        result: &mut Vec<Vec<i32>>,
    ) {
        if let Some(rc_node) = node {
            let mut node_ref = rc_node.borrow_mut();

            current_path.push(node_ref.val);
            let new_remaining_sum = remaining_sum - node_ref.val;

            if node_ref.left.is_none() && node_ref.right.is_none() { // It's a leaf node
                if new_remaining_sum == 0 {
                    result.push(current_path.clone());
                }
            } else {
                Self::dfs(node_ref.left.take(), current_path, new_remaining_sum, result);
                Self::dfs(node_ref.right.take(), current_path, new_remaining_sum, result);
            }

            current_path.pop(); // Backtrack
        }
    }
}
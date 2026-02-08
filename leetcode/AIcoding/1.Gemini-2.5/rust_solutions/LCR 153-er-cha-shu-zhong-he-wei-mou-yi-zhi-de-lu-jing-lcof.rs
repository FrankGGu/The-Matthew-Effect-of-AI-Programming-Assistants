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
        let mut result = Vec::new();
        let mut current_path = Vec::new();
        Self::dfs(root, &mut current_path, 0, target_sum, &mut result);
        result
    }

    fn dfs(
        node: Option<Rc<RefCell<TreeNode>>>,
        current_path: &mut Vec<i32>,
        current_sum: i32,
        target_sum: i32,
        result: &mut Vec<Vec<i32>>,
    ) {
        if let Some(n_rc) = node {
            let n = n_rc.borrow();
            current_path.push(n.val);
            let new_sum = current_sum + n.val;

            if n.left.is_none() && n.right.is_none() {
                if new_sum == target_sum {
                    result.push(current_path.clone());
                }
            } else {
                Self::dfs(n.left.clone(), current_path, new_sum, target_sum, result);
                Self::dfs(n.right.clone(), current_path, new_sum, target_sum, result);
            }

            current_path.pop();
        }
    }
}
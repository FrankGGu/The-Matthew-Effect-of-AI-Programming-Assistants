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

use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn path_sum(root: Option<Rc<RefCell<TreeNode>>>, target_sum: i32) -> Vec<Vec<i32>> {
        let mut result: Vec<Vec<i32>> = Vec::new();
        let mut current_path: Vec<i32> = Vec::new();

        fn dfs(node: Option<Rc<RefCell<TreeNode>>>, target_sum: i32, current_path: &mut Vec<i32>, result: &mut Vec<Vec<i32>>) {
            if let Some(n) = node {
                let val = n.borrow().val;
                current_path.push(val);

                if n.borrow().left.is_none() && n.borrow().right.is_none() {
                    if target_sum == val {
                        result.push(current_path.clone());
                    }
                } else {
                    dfs(n.borrow().left.clone(), target_sum - val, current_path, result);
                    dfs(n.borrow().right.clone(), target_sum - val, current_path, result);
                }

                current_path.pop();
            }
        }

        dfs(root, target_sum, &mut current_path, &mut result);
        result
    }
}

struct Solution;
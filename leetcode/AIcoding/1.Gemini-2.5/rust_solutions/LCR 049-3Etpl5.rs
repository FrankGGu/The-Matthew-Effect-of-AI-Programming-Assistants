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
    pub fn sum_numbers(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        Self::dfs(root, 0)
    }

    fn dfs(node: Option<Rc<RefCell<TreeNode>>>, current_num: i32) -> i32 {
        if let Some(n_rc) = node {
            let n = n_rc.borrow();
            let new_current_num = current_num * 10 + n.val;

            if n.left.is_none() && n.right.is_none() {
                new_current_num
            } else {
                let left_sum = Self::dfs(n.left.clone(), new_current_num);
                let right_sum = Self::dfs(n.right.clone(), new_current_num);
                left_sum + right_sum
            }
        } else {
            0
        }
    }
}
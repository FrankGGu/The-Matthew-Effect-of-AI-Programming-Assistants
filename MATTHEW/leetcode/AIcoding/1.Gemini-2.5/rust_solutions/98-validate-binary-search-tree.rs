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
    pub fn is_valid_bst(root: Option<Rc<RefCell<TreeNode>>>) -> bool {
        Self::check_bst(root, None, None)
    }

    fn check_bst(node: Option<Rc<RefCell<TreeNode>>>, min_val: Option<i64>, max_val: Option<i64>) -> bool {
        if let Some(n_rc) = node {
            let n = n_rc.borrow();
            let current_val = n.val as i64;

            if let Some(min) = min_val {
                if current_val <= min {
                    return false;
                }
            }
            if let Some(max) = max_val {
                if current_val >= max {
                    return false;
                }
            }

            let left_is_valid = Self::check_bst(n.left.clone(), min_val, Some(current_val));
            let right_is_valid = Self::check_bst(n.right.clone(), Some(current_val), max_val);

            left_is_valid && right_is_valid
        } else {
            true
        }
    }
}
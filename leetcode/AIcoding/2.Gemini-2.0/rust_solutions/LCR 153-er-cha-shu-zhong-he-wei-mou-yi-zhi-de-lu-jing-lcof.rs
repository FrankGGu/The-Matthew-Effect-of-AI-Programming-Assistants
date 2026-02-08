use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn has_path_sum(root: Option<Rc<RefCell<TreeNode>>>, target_sum: i32) -> bool {
        match root {
            Some(node) => {
                let val = node.borrow().val;
                let left = node.borrow().left.clone();
                let right = node.borrow().right.clone();

                if left.is_none() && right.is_none() {
                    return val == target_sum;
                }

                if let Some(left_node) = left {
                    if Solution::has_path_sum(Some(left_node), target_sum - val) {
                        return true;
                    }
                }

                if let Some(right_node) = right {
                    if Solution::has_path_sum(Some(right_node), target_sum - val) {
                        return true;
                    }
                }

                false
            }
            None => false,
        }
    }
}

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
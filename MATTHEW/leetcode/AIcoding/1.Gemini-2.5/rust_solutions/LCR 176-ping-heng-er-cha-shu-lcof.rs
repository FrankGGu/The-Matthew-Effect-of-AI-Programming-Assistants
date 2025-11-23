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
    fn _height(node: &Option<Rc<RefCell<TreeNode>>>) -> i32 {
        if let Some(n) = node {
            let n_borrow = n.borrow();
            let left_height = Solution::_height(&n_borrow.left);
            if left_height == -1 {
                return -1;
            }
            let right_height = Solution::_height(&n_borrow.right);
            if right_height == -1 {
                return -1;
            }

            if (left_height - right_height).abs() > 1 {
                return -1;
            } else {
                return 1 + left_height.max(right_height);
            }
        }
        0
    }

    pub fn is_balanced(root: Option<Rc<RefCell<TreeNode>>>) -> bool {
        Solution::_height(&root) != -1
    }
}
use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn range_sum_bst(root: Option<Rc<RefCell<TreeNode>>>, low: i32, high: i32) -> i32 {
        match root {
            Some(node) => {
                let val = node.borrow().val;
                let mut sum = 0;
                if val >= low && val <= high {
                    sum += val;
                }
                if val > low {
                    sum += Self::range_sum_bst(node.borrow().left.clone(), low, high);
                }
                if val < high {
                    sum += Self::range_sum_bst(node.borrow().right.clone(), low, high);
                }
                sum
            }
            None => 0,
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
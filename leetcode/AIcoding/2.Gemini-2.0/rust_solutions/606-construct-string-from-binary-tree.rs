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
    pub fn tree2str(root: Option<Rc<RefCell<TreeNode>>>) -> String {
        match root {
            None => String::new(),
            Some(node) => {
                let node_ref = node.borrow();
                let val = node_ref.val.to_string();
                let left = node_ref.left.clone();
                let right = node_ref.right.clone();

                if left.is_none() && right.is_none() {
                    val
                } else if right.is_none() {
                    val + "(" + &Solution::tree2str(left) + ")"
                } else {
                    val + "(" + &Solution::tree2str(left) + ")" + "(" + &Solution::tree2str(right) + ")"
                }
            }
        }
    }
}

struct Solution;
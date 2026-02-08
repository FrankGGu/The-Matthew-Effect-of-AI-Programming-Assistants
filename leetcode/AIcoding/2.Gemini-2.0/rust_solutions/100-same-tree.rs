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
    pub fn is_same_tree(p: Option<Rc<RefCell<TreeNode>>>, q: Option<Rc<RefCell<TreeNode>>>) -> bool {
        match (p, q) {
            (None, None) => true,
            (Some(p_node), Some(q_node)) => {
                let p_borrowed = p_node.borrow();
                let q_borrowed = q_node.borrow();
                p_borrowed.val == q_borrowed.val &&
                Self::is_same_tree(p_borrowed.left.clone(), q_borrowed.left.clone()) &&
                Self::is_same_tree(p_borrowed.right.clone(), q_borrowed.right.clone())
            }
            _ => false,
        }
    }
}

struct Solution;
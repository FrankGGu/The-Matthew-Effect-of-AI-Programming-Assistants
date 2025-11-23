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
    pub fn is_symmetric(root: Option<Rc<RefCell<TreeNode>>>) -> bool {
        fn is_mirror(left: Option<Rc<RefCell<TreeNode>>>, right: Option<Rc<RefCell<TreeNode>>>) -> bool {
            match (left, right) {
                (None, None) => true,
                (Some(l), Some(r)) => {
                    let l_borrow = l.borrow();
                    let r_borrow = r.borrow();
                    l_borrow.val == r_borrow.val &&
                    is_mirror(l_borrow.left.clone(), r_borrow.right.clone()) &&
                    is_mirror(l_borrow.right.clone(), r_borrow.left.clone())
                },
                _ => false,
            }
        }

        match root {
            None => true,
            Some(node) => {
                let borrowed_node = node.borrow();
                is_mirror(borrowed_node.left.clone(), borrowed_node.right.clone())
            }
        }
    }
}
use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn prune_tree(root: Option<Rc<RefCell<TreeNode>>>) -> Option<Rc<RefCell<TreeNode>>> {
        if root.is_none() {
            return None;
        }

        let mut root_node = root.unwrap();
        let mut root_borrow = root_node.borrow_mut();

        root_borrow.left = Self::prune_tree(root_borrow.left.take());
        root_borrow.right = Self::prune_tree(root_borrow.right.take());

        if root_borrow.val == 0 && root_borrow.left.is_none() && root_borrow.right.is_none() {
            return None;
        }

        Some(root_node)
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
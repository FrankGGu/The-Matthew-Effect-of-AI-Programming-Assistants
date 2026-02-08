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
    pub fn prune_tree(root: Option<Rc<RefCell<TreeNode>>>) -> Option<Rc<RefCell<TreeNode>>> {
        if root.is_none() {
            return None;
        }

        let node_rc = root.unwrap();
        let mut node = node_rc.borrow_mut();

        node.left = Self::prune_tree(node.left.take());
        node.right = Self::prune_tree(node.right.take());

        if node.val == 0 && node.left.is_none() && node.right.is_none() {
            None
        } else {
            drop(node); // Explicitly drop the RefMut to allow `node_rc` to be returned
            Some(node_rc)
        }
    }
}
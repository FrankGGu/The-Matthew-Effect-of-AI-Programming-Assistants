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
    pub fn search_bst(root: Option<Rc<RefCell<TreeNode>>>, target: i32) -> Option<Rc<RefCell<TreeNode>>> {
        let mut current_node_option = root;

        while let Some(node_rc) = current_node_option {
            let node_ref = node_rc.borrow();

            if node_ref.val == target {
                return Some(node_rc);
            } else if node_ref.val > target {
                current_node_option = node_ref.left.clone();
            } else {
                current_node_option = node_ref.right.clone();
            }
        }

        None
    }
}
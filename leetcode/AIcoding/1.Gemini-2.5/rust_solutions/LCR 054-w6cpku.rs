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
    pub fn convert_bst(root: Option<Rc<RefCell<TreeNode>>>) -> Option<Rc<RefCell<TreeNode>>> {
        let mut current_sum: i32 = 0;
        Self::traverse_and_sum(root.clone(), &mut current_sum);
        root
    }

    fn traverse_and_sum(node_option: Option<Rc<RefCell<TreeNode>>>, current_sum: &mut i32) {
        if let Some(node_rc) = node_option {
            // Traverse right subtree first (nodes with greater values)
            Self::traverse_and_sum(node_rc.borrow().right.clone(), current_sum);

            // Process current node
            let mut node_borrow = node_rc.borrow_mut();
            node_borrow.val += *current_sum;
            *current_sum = node_borrow.val;

            // Traverse left subtree
            Self::traverse_and_sum(node_borrow.left.clone(), current_sum);
        }
    }
}
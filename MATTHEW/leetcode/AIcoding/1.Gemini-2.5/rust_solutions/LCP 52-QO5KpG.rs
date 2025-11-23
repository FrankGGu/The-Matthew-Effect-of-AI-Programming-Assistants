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

struct Solution {}

impl Solution {
    pub fn bst_to_gst(root: Option<Rc<RefCell<TreeNode>>>) -> Option<Rc<RefCell<TreeNode>>> {
        let mut sum = 0;
        Self::traverse_and_sum(root.clone(), &mut sum);
        root
    }

    fn traverse_and_sum(node: Option<Rc<RefCell<TreeNode>>>, sum: &mut i32) {
        if let Some(node_rc) = node {
            Self::traverse_and_sum(node_rc.borrow().right.clone(), sum);
            *sum += node_rc.borrow().val;
            node_rc.borrow_mut().val = *sum;
            Self::traverse_and_sum(node_rc.borrow().left.clone(), sum);
        }
    }
}
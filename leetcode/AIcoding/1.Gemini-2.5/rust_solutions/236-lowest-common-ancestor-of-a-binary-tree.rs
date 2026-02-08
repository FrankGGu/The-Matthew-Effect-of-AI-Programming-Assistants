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
    pub fn lowest_common_ancestor(root: Option<Rc<RefCell<TreeNode>>>, p: Option<Rc<RefCell<TreeNode>>>, q: Option<Rc<RefCell<TreeNode>>>) -> Option<Rc<RefCell<TreeNode>>> {
        let root_rc = match root {
            Some(node) => node,
            None => return None,
        };

        if p.as_ref().map_or(false, |node_p_rc| Rc::ptr_eq(&root_rc, node_p_rc)) ||
           q.as_ref().map_or(false, |node_q_rc| Rc::ptr_eq(&root_rc, node_q_rc)) {
            return Some(root_rc);
        }

        let left_lca = Self::lowest_common_ancestor(root_rc.borrow().left.clone(), p.clone(), q.clone());
        let right_lca = Self::lowest_common_ancestor(root_rc.borrow().right.clone(), p.clone(), q.clone());

        match (left_lca, right_lca) {
            (Some(left), Some(right)) => Some(root_rc),
            (Some(left), None) => Some(left),
            (None, Some(right)) => Some(right),
            (None, None) => None,
        }
    }
}
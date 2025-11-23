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

struct BSTIterator {
    stack: Vec<Rc<RefCell<TreeNode>>>,
}

impl BSTIterator {
    fn new(root: Option<Rc<RefCell<TreeNode>>>) -> Self {
        let mut stack = Vec::new();
        let mut current = root;

        while let Some(node_rc) = current {
            stack.push(Rc::clone(&node_rc));
            current = node_rc.borrow().left.clone();
        }

        BSTIterator { stack }
    }

    fn next(&mut self) -> i32 {
        let node_rc = self.stack.pop().unwrap();
        let node_val = node_rc.borrow().val;

        let mut current_right = node_rc.borrow().right.clone();
        while let Some(right_child_rc) = current_right {
            self.stack.push(Rc::clone(&right_child_rc));
            current_right = right_child_rc.borrow().left.clone();
        }

        node_val
    }

    fn has_next(&self) -> bool {
        !self.stack.is_empty()
    }
}
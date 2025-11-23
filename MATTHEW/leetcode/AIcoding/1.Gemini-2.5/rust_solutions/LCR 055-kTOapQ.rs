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
        let mut iter = BSTIterator {
            stack: Vec::new(),
        };
        iter.push_left_children(root);
        iter
    }

    fn push_left_children(&mut self, mut node_opt: Option<Rc<RefCell<TreeNode>>>) {
        while let Some(node_rc) = node_opt {
            self.stack.push(Rc::clone(&node_rc));
            node_opt = node_rc.borrow().left.clone();
        }
    }

    fn next(&mut self) -> i32 {
        let node_rc = self.stack.pop().unwrap();
        let node_val = node_rc.borrow().val;

        if let Some(right_child) = node_rc.borrow().right.clone() {
            self.push_left_children(Some(right_child));
        }

        node_val
    }

    fn has_next(&self) -> bool {
        !self.stack.is_empty()
    }
}
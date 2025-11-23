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
        let mut iterator = BSTIterator { stack: Vec::new() };
        let mut current = root;
        while let Some(node) = current {
            iterator.stack.push(Rc::clone(&node));
            current = node.borrow().left.clone();
        }
        iterator
    }

    fn next(&mut self) -> i32 {
        let top = self.stack.pop().unwrap();
        let val = top.borrow().val;
        let mut current = top.borrow().right.clone();
        while let Some(node) = current {
            self.stack.push(Rc::clone(&node));
            current = node.borrow().left.clone();
        }
        val
    }

    fn has_next(&self) -> bool {
        !self.stack.is_empty()
    }
}
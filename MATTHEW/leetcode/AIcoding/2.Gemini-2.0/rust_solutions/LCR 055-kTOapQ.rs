use std::rc::Rc;
use std::cell::RefCell;

struct BSTIterator {
    stack: Vec<Rc<RefCell<TreeNode>>>,
}

impl BSTIterator {
    fn new(root: Option<Rc<RefCell<TreeNode>>>) -> Self {
        let mut iterator = BSTIterator { stack: Vec::new() };
        let mut current = root;
        while let Some(node) = current {
            iterator.stack.push(node.clone());
            current = node.borrow().left.clone();
        }
        iterator
    }

    fn next(&mut self) -> i32 {
        let top = self.stack.pop().unwrap();
        let value = top.borrow().val;
        let mut current = top.borrow().right.clone();
        while let Some(node) = current {
            self.stack.push(node.clone());
            current = node.borrow().left.clone();
        }
        value
    }

    fn has_next(&self) -> bool {
        !self.stack.is_empty()
    }
}
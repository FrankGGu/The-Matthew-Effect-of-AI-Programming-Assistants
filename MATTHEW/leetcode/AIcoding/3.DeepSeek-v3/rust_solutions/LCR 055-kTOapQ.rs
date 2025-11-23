use std::rc::Rc;
use std::cell::RefCell;

struct BSTIterator {
    stack: Vec<Rc<RefCell<TreeNode>>>,
}

impl BSTIterator {
    fn new(root: Option<Rc<RefCell<TreeNode>>>) -> Self {
        let mut stack = Vec::new();
        let mut node = root;
        while let Some(n) = node {
            stack.push(Rc::clone(&n));
            node = n.borrow().left.clone();
        }
        BSTIterator { stack }
    }

    fn next(&mut self) -> i32 {
        let node = self.stack.pop().unwrap();
        let val = node.borrow().val;
        let mut current = node.borrow().right.clone();
        while let Some(n) = current {
            self.stack.push(Rc::clone(&n));
            current = n.borrow().left.clone();
        }
        val
    }

    fn has_next(&self) -> bool {
        !self.stack.is_empty()
    }
}
use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn connect(root: Option<Rc<RefCell<Node>>>) -> Option<Rc<RefCell<Node>>> {
        let mut current = root.clone();
        let mut dummy = Rc::new(RefCell::new(Node::new(0)));
        let mut prev = dummy.clone();

        while current.is_some() {
            let mut node = current.take().unwrap();
            let mut node_ref = node.borrow_mut();

            if node_ref.left.is_some() {
                prev.borrow_mut().next = node_ref.left.clone();
                prev = prev.borrow().next.clone().unwrap();
            }

            if node_ref.right.is_some() {
                prev.borrow_mut().next = node_ref.right.clone();
                prev = prev.borrow().next.clone().unwrap();
            }

            current = node_ref.next.clone();
        }

        if dummy.borrow().next.is_some() {
            Self::connect(dummy.borrow().next.clone());
        }

        root
    }
}
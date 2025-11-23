#[derive(Debug, PartialEq, Eq)]
pub struct Node {
    pub val: i32,
    pub prev: Option<Rc<RefCell<Node>>>,
    pub next: Option<Rc<RefCell<Node>>>,
    pub child: Option<Rc<RefCell<Node>>>,
}

impl Node {
    #[inline]
    pub fn new(val: i32) -> Self {
        Node {
            val,
            prev: None,
            next: None,
            child: None,
        }
    }
}

use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn flatten(head: Option<Rc<RefCell<Node>>>) -> Option<Rc<RefCell<Node>>> {
        let mut current = head.clone();
        while let Some(node) = current {
            let mut node_borrow = node.borrow_mut();
            if let Some(child) = node_borrow.child.take() {
                let next = node_borrow.next.take();
                let mut child_tail = child.clone();
                while let Some(next_node) = child_tail.borrow().next.clone() {
                    child_tail = next_node;
                }
                node_borrow.next = Some(child.clone());
                child.borrow_mut().prev = Some(node.clone());
                if let Some(next) = next {
                    child_tail.borrow_mut().next = Some(next.clone());
                    next.borrow_mut().prev = Some(child_tail);
                }
            }
            current = node_borrow.next.clone();
        }
        head
    }
}
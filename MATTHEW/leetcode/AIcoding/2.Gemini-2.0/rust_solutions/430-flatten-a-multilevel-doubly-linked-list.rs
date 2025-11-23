#[derive(Debug, PartialEq, Eq, Clone)]
pub struct Node {
    pub val: i32,
    pub prev: Option<Rc<RefCell<Node>>>,
    pub next: Option<Rc<RefCell<Node>>>,
    pub child: Option<Rc<RefCell<Node>>>,
}

impl Node {
    #[inline]
    fn new(val: i32) -> Self {
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

        while let Some(node_rc) = current {
            let mut node = node_rc.borrow_mut();

            if node.child.is_some() {
                let child_rc = node.child.take().unwrap();
                let next_rc = node.next.take();

                let mut child_head = Some(child_rc.clone());
                let mut child_tail = child_rc.clone();

                while let Some(ref next_child) = child_tail.borrow().next {
                    child_tail = next_child.clone();
                }

                node.next = Some(child_rc.clone());
                child_rc.borrow_mut().prev = Some(node_rc.clone());

                if let Some(next_node_rc) = next_rc {
                    child_tail.borrow_mut().next = Some(next_node_rc.clone());
                    next_node_rc.borrow_mut().prev = Some(child_tail.clone());

                }

                current = node.next.clone();
            } else {
                current = node.next.clone();
            }
        }

        head
    }
}

struct Solution;
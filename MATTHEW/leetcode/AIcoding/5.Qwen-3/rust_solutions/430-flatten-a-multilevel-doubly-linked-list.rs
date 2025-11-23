impl Solution {

use std::cell::RefCell;
use std::rc::Rc;

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

struct Solution;

impl Solution {
    pub fn flatten(head: Option<Rc<RefCell<Node>>>) -> Option<Rc<RefCell<Node>>> {
        let mut stack = Vec::new();
        let mut current = head.clone();
        let mut prev = None;

        while let Some(node) = current {
            let node_ref = node.borrow();
            if let Some(child) = &node_ref.child {
                if let Some(next) = &node_ref.next {
                    stack.push(next.clone());
                }
                current = Some(child.clone());
            } else {
                if let Some(next) = &node_ref.next {
                    current = Some(next.clone());
                } else {
                    if let Some(top) = stack.pop() {
                        current = Some(top);
                    } else {
                        current = None;
                    }
                }
            }

            if let Some(prev_node) = prev {
                let mut prev_mut = prev_node.borrow_mut();
                prev_mut.next = Some(node.clone());
            }

            let mut node_mut = node.borrow_mut();
            node_mut.prev = prev;
            prev = Some(node);
        }

        head
    }
}
}
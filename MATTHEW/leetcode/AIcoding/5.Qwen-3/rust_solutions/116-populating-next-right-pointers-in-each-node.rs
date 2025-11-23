impl Solution {

use std::borrow::Cow;
use std::cell::RefCell;
use std::rc::Rc;

#[derive(Debug, PartialEq, Eq)]
pub struct Node {
    pub val: i32,
    pub left: Option<Rc<RefCell<Node>>>,
    pub right: Option<Rc<RefCell<Node>>>,
    pub next: Option<Rc<RefCell<Node>>>,
}

impl Node {
    #[inline]
    pub fn new(val: i32) -> Self {
        Self {
            val,
            left: None,
            right: None,
            next: None,
        }
    }
}

pub fn connect(root: Option<Rc<RefCell<Node>>>) -> Option<Rc<RefCell<Node>>> {
    let mut current = root.clone();
    while let Some(node) = current {
        let mut level_head = None;
        let mut prev = None;
        let mut node_borrow = node.borrow_mut();
        let mut next_level = None;
        if let Some(left) = &node_borrow.left {
            if let Some(prev) = prev.as_ref() {
                prev.borrow_mut().next = Some(left.clone());
            } else {
                level_head = Some(left.clone());
            }
            prev = Some(left.clone());
            next_level = Some(left.clone());
        }
        if let Some(right) = &node_borrow.right {
            if let Some(prev) = prev.as_ref() {
                prev.borrow_mut().next = Some(right.clone());
            } else {
                level_head = Some(right.clone());
            }
            prev = Some(right.clone());
            next_level = Some(right.clone());
        }
        drop(node_borrow);
        current = level_head;
    }
    root
}
}
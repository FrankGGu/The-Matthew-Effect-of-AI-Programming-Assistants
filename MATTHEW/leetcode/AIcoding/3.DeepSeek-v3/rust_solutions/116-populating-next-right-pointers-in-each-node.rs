use std::rc::Rc;
use std::cell::RefCell;
use std::collections::VecDeque;

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
        Node {
            val,
            left: None,
            right: None,
            next: None,
        }
    }
}

pub fn connect(root: Option<Rc<RefCell<Node>>>) -> Option<Rc<RefCell<Node>>> {
    if root.is_none() {
        return None;
    }
    let mut queue = VecDeque::new();
    queue.push_back(root.clone());
    while !queue.is_empty() {
        let level_size = queue.len();
        let mut prev: Option<Rc<RefCell<Node>>> = None;
        for _ in 0..level_size {
            if let Some(node) = queue.pop_front().unwrap() {
                let mut node_borrow = node.borrow_mut();
                if let Some(prev_node) = prev {
                    prev_node.borrow_mut().next = Some(node.clone());
                }
                prev = Some(node.clone());
                if node_borrow.left.is_some() {
                    queue.push_back(node_borrow.left.clone());
                }
                if node_borrow.right.is_some() {
                    queue.push_back(node_borrow.right.clone());
                }
            }
        }
    }
    root
}
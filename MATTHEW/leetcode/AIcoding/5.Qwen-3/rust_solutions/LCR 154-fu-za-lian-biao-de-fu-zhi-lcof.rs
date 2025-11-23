impl Solution {

use std::collections::HashMap;
use std::rc::Rc;
use std::cell::RefCell;

#[derive(Clone, PartialEq, Eq, Debug)]
pub struct Node {
    pub val: i32,
    pub next: Option<Rc<RefCell<Node>>>,
    pub random: Option<Rc<RefCell<Node>>>,
}

impl Node {
    pub fn new(val: i32) -> Self {
        Node {
            val,
            next: None,
            random: None,
        }
    }
}

pub fn copy_random_list(head: Option<Rc<RefCell<Node>>>) -> Option<Rc<RefCell<Node>>> {
    if head.is_none() {
        return None;
    }

    let mut map = HashMap::new();
    let mut current = head.clone();

    while let Some(node) = current {
        let node_val = node.borrow().val;
        let new_node = Rc::new(RefCell::new(Node::new(node_val)));
        map.insert(node, new_node);
        current = node.borrow().next.clone();
    }

    current = head.clone();
    while let Some(node) = current {
        let new_node = map.get(&node).unwrap();
        if let Some(next) = node.borrow().next.clone() {
            new_node.borrow_mut().next = map.get(&next).cloned();
        }
        if let Some(random) = node.borrow().random.clone() {
            new_node.borrow_mut().random = map.get(&random).cloned();
        }
        current = node.borrow().next.clone();
    }

    map.get(&head.unwrap()).cloned()
}
}
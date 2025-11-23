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
        let node_ref = node.borrow();
        map.insert(&*node_ref, Rc::new(RefCell::new(Node::new(node_ref.val))));
        current = node_ref.next.clone();
    }

    current = head.clone();
    while let Some(node) = current {
        let node_ref = node.borrow();
        let copy = map.get(&*node_ref).unwrap();
        copy.borrow_mut().next = node_ref.next.as_ref().and_then(|n| map.get(n).cloned());
        copy.borrow_mut().random = node_ref.random.as_ref().and_then(|r| map.get(r).cloned());
        current = node_ref.next.clone();
    }

    map.get(&*head.as_ref().unwrap().borrow()).cloned()
}
}
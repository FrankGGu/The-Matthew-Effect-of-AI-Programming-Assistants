impl Solution {

use std::cell::RefCell;
use std::rc::Rc;

#[derive(PartialEq, Eq, Clone, Debug)]
pub struct ListNode {
    pub val: i32,
    pub next: Option<Rc<RefCell<ListNode>>>,
}

impl ListNode {
    #[inline]
    pub fn new(val: i32) -> Self {
        ListNode { next: None, val }
    }
}

pub fn swap_nodes(head: Option<Rc<RefCell<ListNode>>>, k: i32) -> Option<Rc<RefCell<ListNode>>> {
    let mut dummy = Rc::new(RefCell::new(ListNode::new(0)));
    let mut current = Some(dummy.clone());
    let mut nodes = Vec::new();

    while let Some(node) = current {
        nodes.push(node);
        current = node.borrow().next.clone();
    }

    let len = nodes.len() as i32;
    let i = k - 1;
    let j = len - k;

    if i == j {
        return Some(dummy.borrow().next.clone().unwrap());
    }

    let node_i = nodes[i as usize].clone();
    let node_j = nodes[j as usize].clone();

    let mut prev_i = None;
    let mut prev_j = None;

    for node in &nodes {
        if node.borrow().next.as_ref() == Some(&node_i) {
            prev_i = Some(node.clone());
        }
        if node.borrow().next.as_ref() == Some(&node_j) {
            prev_j = Some(node.clone());
        }
    }

    let next_i = node_i.borrow().next.clone();
    let next_j = node_j.borrow().next.clone();

    if let Some(prev) = prev_i {
        prev.borrow_mut().next = Some(node_j);
    } else {
        dummy.borrow_mut().next = Some(node_j);
    }

    if let Some(prev) = prev_j {
        prev.borrow_mut().next = Some(node_i);
    } else {
        dummy.borrow_mut().next = Some(node_i);
    }

    node_i.borrow_mut().next = next_j;
    node_j.borrow_mut().next = next_i;

    Some(dummy.borrow().next.clone().unwrap())
}
}
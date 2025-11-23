impl Solution {

use std::rc::Rc;
use std::cell::RefCell;

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

pub fn delete_node(node: Rc<RefCell<ListNode>>) {
    let next = node.borrow().next.clone();
    if let Some(next) = next {
        node.borrow_mut().val = next.borrow().val;
        node.borrow_mut().next = next.borrow().next.clone();
    }
}
}
impl Solution {

use std::cmp::Ordering;
use std::cell::RefCell;
use std::rc::Rc;

type Link = Option<Rc<RefCell<ListNode>>>;

#[derive(PartialEq, Eq, Clone, Debug)]
pub struct ListNode {
    pub val: i32,
    pub next: Link,
}

impl ListNode {
    #[inline]
    pub fn new(val: i32) -> Self {
        ListNode { next: None, val }
    }
}

pub fn partition(head: Link, x: i32) -> Link {
    let mut less_head = Rc::new(RefCell::new(ListNode::new(0)));
    let mut more_head = Rc::new(RefCell::new(ListNode::new(0)));
    let mut less = less_head.clone();
    let mut more = more_head.clone();
    let mut current = head;

    while let Some(node) = current {
        let val = node.borrow().val;
        match val.cmp(&x) {
            Ordering::Less => {
                less.borrow_mut().next = Some(node.clone());
                less = less.borrow_mut().next.as_ref().unwrap().clone();
            }
            _ => {
                more.borrow_mut().next = Some(node.clone());
                more = more.borrow_mut().next.as_ref().unwrap().clone();
            }
        }
        current = node.borrow().next.clone();
    }

    more.borrow_mut().next = None;
    less.borrow_mut().next = more_head.borrow().next.clone();

    less_head.borrow().next.clone()
}
}
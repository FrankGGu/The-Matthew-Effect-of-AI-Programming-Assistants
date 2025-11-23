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
    fn new(val: i32) -> Self {
        ListNode { next: None, val }
    }
}

pub fn reorder_list(head: &Rc<RefCell<ListNode>>) {
    if head.next.is_none() {
        return;
    }

    let mut slow = head.clone();
    let mut fast = head.clone();

    while let Some(next_fast) = fast.borrow().next.as_ref() {
        fast = next_fast.clone();
        if let Some(next_slow) = slow.borrow().next.as_ref() {
            slow = next_slow.clone();
        }
    }

    let mut second_half = slow.borrow_mut().next.take();

    let mut prev: Option<Rc<RefCell<ListNode>>> = None;
    while let Some(mut current) = second_half {
        let next = current.borrow_mut().next.take();
        current.borrow_mut().next = prev;
        prev = Some(current);
        second_half = next;
    }

    let mut first = head.clone();
    let mut second = prev;

    while let Some(mut first_node) = first {
        let first_next = first_node.borrow_mut().next.take();
        let second_node = second.as_ref().unwrap().clone();
        let second_next = second_node.borrow_mut().next.take();

        first_node.borrow_mut().next = Some(second_node);
        second = second_next;

        first = first_next;
    }
}
}
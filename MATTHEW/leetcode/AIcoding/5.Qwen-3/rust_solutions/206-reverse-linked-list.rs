impl Solution {

use std::ptr::NonNull;

#[derive(PartialEq, Eq, Clone, Debug)]
pub struct ListNode {
    pub val: i32,
    pub next: Option<Box<ListNode>>,
}

impl ListNode {
    #[inline]
    pub fn new(val: i32) -> Self {
        ListNode { next: None, val }
    }
}

pub fn reverse_list(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
    let mut prev: Option<Box<ListNode>> = None;
    let mut current = head;

    while let Some(mut node) = current {
        let next = node.next;
        node.next = prev;
        prev = Some(node);
        current = next;
    }

    prev
}
}
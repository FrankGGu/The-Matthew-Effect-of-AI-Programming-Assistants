#[derive(PartialEq, Eq, Clone, Debug)]
pub struct ListNode {
    pub val: i32,
    pub next: Option<Box<ListNode>>
}

impl ListNode {
    #[inline]
    fn new(val: i32) -> Self {
        ListNode {
            next: None,
            val
        }
    }
}

use std::cmp::Ordering;
use std::collections::BinaryHeap;

impl PartialOrd for ListNode {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        other.val.partial_cmp(&self.val)
    }
}

impl Ord for ListNode {
    fn cmp(&self, other: &Self) -> Ordering {
        other.val.cmp(&self.val)
    }
}

pub fn merge_k_lists(lists: Vec<Option<Box<ListNode>>>) -> Option<Box<ListNode>> {
    let mut heap = BinaryHeap::new();
    for list in lists {
        if let Some(node) = list {
            heap.push(node);
        }
    }
    let mut dummy = ListNode::new(0);
    let mut current = &mut dummy;
    while let Some(node) = heap.pop() {
        current.next = Some(Box::new(ListNode::new(node.val)));
        current = current.next.as_mut().unwrap();
        if let Some(next) = node.next {
            heap.push(next);
        }
    }
    dummy.next
}
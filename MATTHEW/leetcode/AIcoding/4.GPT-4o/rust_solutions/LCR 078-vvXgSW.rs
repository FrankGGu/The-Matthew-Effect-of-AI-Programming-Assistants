use std::cmp::Ordering;
use std::collections::BinaryHeap;

#[derive(Eq)]
struct ListNode {
    val: i32,
    next: Option<Box<ListNode>>,
}

impl Ord for ListNode {
    fn cmp(&self, other: &Self) -> Ordering {
        other.val.cmp(&self.val)
    }
}

impl PartialOrd for ListNode {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        Some(self.cmp(other))
    }
}

impl PartialEq for ListNode {
    fn eq(&self, other: &Self) -> bool {
        self.val == other.val
    }
}

impl ListNode {
    fn new(val: i32) -> Self {
        ListNode { val, next: None }
    }
}

pub fn merge_k_lists(lists: Vec<Option<Box<ListNode>>>) -> Option<Box<ListNode>> {
    let mut heap = BinaryHeap::new();

    for list in lists {
        if let Some(node) = list {
            heap.push(*node);
        }
    }

    let mut dummy = ListNode::new(0);
    let mut current = &mut dummy;

    while let Some(mut node) = heap.pop() {
        current.next = Some(Box::new(node.clone()));
        current = current.next.as_mut().unwrap();
        if let Some(next) = node.next {
            heap.push(*next);
        }
    }

    dummy.next
}
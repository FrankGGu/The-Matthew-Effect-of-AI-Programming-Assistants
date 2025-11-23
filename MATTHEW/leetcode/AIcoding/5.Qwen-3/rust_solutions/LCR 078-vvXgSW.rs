impl Solution {

use std::cmp::Ordering;
use std::collections::BinaryHeap;

#[derive(PartialEq, Eq)]
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

pub struct Solution;

impl Solution {
    pub fn merge_k_lists(lists: Vec<Option<Box<ListNode>>>) -> Option<Box<ListNode>> {
        let mut heap = BinaryHeap::new();

        for list in lists {
            if let Some(node) = list {
                heap.push(Reverse(node));
            }
        }

        let mut dummy = Box::new(ListNode::new(0));
        let mut current = &mut dummy;

        while let Some(Reverse(mut node)) = heap.pop() {
            if let Some(next) = node.next {
                heap.push(Reverse(next));
            }
            current.next = Some(node);
            current = current.next.as_mut().unwrap();
        }

        dummy.next
    }
}

struct Reverse(Box<ListNode>);

impl PartialEq for Reverse {
    fn eq(&self, other: &Self) -> bool {
        self.0.val == other.0.val
    }
}

impl Eq for Reverse {}

impl Ord for Reverse {
    fn cmp(&self, other: &Self) -> Ordering {
        other.0.val.cmp(&self.0.val)
    }
}

impl PartialOrd for Reverse {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        Some(self.cmp(other))
    }
}
}
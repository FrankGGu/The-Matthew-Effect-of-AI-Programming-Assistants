use std::cmp::Ordering;
use std::collections::BinaryHeap;

#[derive(PartialEq, Eq, Debug)]
struct Node {
    val: i32,
    next: Option<Box<ListNode>>,
}

impl Ord for Node {
    fn cmp(&self, other: &Self) -> Ordering {
        other.val.cmp(&self.val)
    }
}

impl PartialOrd for Node {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        Some(self.cmp(other))
    }
}

#[derive(PartialEq, Eq, Clone, Debug)]
pub struct ListNode {
    pub val: i32,
    pub next: Option<Box<ListNode>>,
}

impl ListNode {
    #[inline]
    fn new(val: i32) -> Self {
        ListNode { next: None, val }
    }
}

impl Solution {
    pub fn merge_k_lists(lists: Vec<Option<Box<ListNode>>>) -> Option<Box<ListNode>> {
        let mut heap = BinaryHeap::new();

        for list in lists {
            if let Some(node) = list {
                heap.push(Node { val: node.val, next: node.next });
            }
        }

        let mut dummy = ListNode::new(0);
        let mut tail = &mut dummy;

        while let Some(node) = heap.pop() {
            tail.next = Some(Box::new(ListNode::new(node.val)));
            tail = tail.next.as_mut().unwrap();

            if let Some(next_node) = node.next {
                heap.push(Node { val: next_node.val, next: next_node.next });
            }
        }

        dummy.next
    }
}

struct Solution;
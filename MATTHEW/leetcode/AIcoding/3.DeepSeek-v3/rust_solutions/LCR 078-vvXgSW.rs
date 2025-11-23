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

impl Solution {
    pub fn merge_k_lists(lists: Vec<Option<Box<ListNode>>>) -> Option<Box<ListNode>> {
        let mut heap = BinaryHeap::new();
        for list in lists {
            if let Some(node) = list {
                heap.push(node);
            }
        }
        let mut dummy = ListNode::new(0);
        let mut current = &mut dummy.next;
        while let Some(mut node) = heap.pop() {
            if let Some(next) = node.next.take() {
                heap.push(next);
            }
            *current = Some(node);
            current = &mut current.as_mut().unwrap().next;
        }
        dummy.next
    }
}
use std::cmp::Ordering;
use std::collections::BinaryHeap;

#[derive(Eq)]
struct Node {
    val: i32,
    list_index: usize,
    element_index: usize,
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

impl PartialEq for Node {
    fn eq(&self, other: &Self) -> bool {
        self.val == other.val
    }
}

pub struct ListNode {
    pub val: i32,
    pub next: Option<Box<ListNode>>,
}

impl ListNode {
    #[inline]
    fn new(val: i32) -> Self {
        ListNode { val, next: None }
    }
}

pub fn merge_k_lists(lists: Vec<Option<Box<ListNode>>>) -> Option<Box<ListNode>> {
    let mut heap = BinaryHeap::new();

    for (i, list) in lists.iter().enumerate() {
        if let Some(node) = list {
            heap.push(Node { val: node.val, list_index: i, element_index: 0 });
        }
    }

    let mut dummy = ListNode::new(0);
    let mut current = &mut dummy;

    while let Some(Node { val, list_index, element_index }) = heap.pop() {
        current.next = Some(Box::new(ListNode::new(val)));
        current = current.next.as_mut().unwrap();

        if let Some(next_node) = lists[list_index].as_ref().and_then(|node| {
            let mut current = node;
            for _ in 0..element_index + 1 {
                current = current.next.as_deref()?;
            }
            current.next.as_deref()
        }) {
            heap.push(Node { val: next_node.val, list_index, element_index: element_index + 1 });
        }
    }

    dummy.next
}
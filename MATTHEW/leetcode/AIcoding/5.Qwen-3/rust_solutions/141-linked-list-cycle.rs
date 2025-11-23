impl Solution {

use std::collections::HashSet;

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

pub fn has_cycle(head: Option<Box<ListNode>>) -> bool {
    let mut visited = HashSet::new();
    let mut current = head;
    while let Some(node) = current {
        if visited.contains(&node) {
            return true;
        }
        visited.insert(node);
        current = node.next;
    }
    false
}
}
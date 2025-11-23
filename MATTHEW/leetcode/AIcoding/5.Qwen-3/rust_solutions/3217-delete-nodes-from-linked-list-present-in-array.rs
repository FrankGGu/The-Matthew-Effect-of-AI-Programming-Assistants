impl Solution {

use std::collections::HashSet;

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

pub fn remove_nodes(mut head: Option<Box<ListNode>>, nums: Vec<i32>) -> Option<Box<ListNode>> {
    let set: HashSet<_> = nums.into_iter().collect();
    let mut dummy = Box::new(ListNode::new(0));
    let mut current = &mut dummy;

    while let Some(mut node) = head {
        head = node.next.take();
        if !set.contains(&node.val) {
            current.next = Some(node);
            current = current.next.as_mut().unwrap();
        }
    }

    dummy.next
}
}
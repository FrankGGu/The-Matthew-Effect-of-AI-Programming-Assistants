impl Solution {

use std::ptr::eq;

#[derive(PartialEq, Eq, Clone, Debug)]
pub struct ListNode {
    pub val: i32,
    pub next: Option<Box<ListNode>>,
}

pub fn get_intersection_node(
    head_a: Option<Box<ListNode>>,
    head_b: Option<Box<ListNode>>,
) -> Option<Box<ListNode>> {
    let mut a = head_a;
    let mut b = head_b;

    while a.is_some() || b.is_some() {
        match (a.as_ref(), b.as_ref()) {
            (Some(node_a), Some(node_b)) if eq(node_a, node_b) => return a,
            _ => {}
        }

        a = a.and_then(|node| node.next);
        b = b.and_then(|node| node.next);
    }

    None
}
}
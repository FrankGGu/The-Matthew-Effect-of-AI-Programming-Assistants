impl Solution {

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

pub fn trainning_plan(head: Option<Box<ListNode>>) -> i32 {
    let mut count = 0;
    let mut current = head;
    while let Some(node) = current {
        count += 1;
        current = node.next;
    }
    count
}
}
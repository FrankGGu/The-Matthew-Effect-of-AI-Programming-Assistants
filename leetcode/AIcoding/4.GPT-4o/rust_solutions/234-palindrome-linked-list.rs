#[derive(PartialEq, Eq, Clone)]
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

pub struct Solution;

impl Solution {
    pub fn is_palindrome(head: Option<Box<ListNode>>) -> bool {
        let mut vals = Vec::new();
        let mut current = head;
        while let Some(node) = current {
            vals.push(node.val);
            current = node.next;
        }
        vals == vals.iter().rev().cloned().collect::<Vec<_>>()
    }
}
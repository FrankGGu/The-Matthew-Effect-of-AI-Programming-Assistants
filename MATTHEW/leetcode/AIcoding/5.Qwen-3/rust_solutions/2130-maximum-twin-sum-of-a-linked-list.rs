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

pub fn pair_sum(head: Option<Box<ListNode>>) -> i32 {
    let mut slow = head.as_ref();
    let mut fast = head.as_ref();

    while let Some(node) = fast {
        slow = slow.and_then(|n| n.next.as_ref());
        fast = node.next.as_ref().and_then(|n| n.next.as_ref());
    }

    let mut prev: Option<Box<ListNode>> = None;
    let mut curr = slow;

    while let Some(mut node) = curr.take() {
        let next = node.next;
        node.next = prev;
        prev = Some(node);
        curr = next;
    }

    let mut max_sum = 0;
    let mut left = head;
    let mut right = prev;

    while let (Some(left_node), Some(right_node)) = (left, right) {
        max_sum = max_sum.max(left_node.val + right_node.val);
        left = left_node.next;
        right = right_node.next;
    }

    max_sum
}
}
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

pub fn rotate_right(head: Option<Box<ListNode>>, k: i32) -> Option<Box<ListNode>> {
    if head.is_none() || k == 0 {
        return head;
    }

    let mut length = 0;
    let mut current = &head;
    while let Some(node) = current {
        length += 1;
        current = &node.next;
    }

    let k = k % length;
    if k == 0 {
        return head;
    }

    let mut slow = &head;
    let mut fast = &head;
    for _ in 0..k {
        fast = &fast.as_ref().unwrap().next;
    }

    while fast.as_ref().is_some() {
        slow = &slow.as_ref().unwrap().next;
        fast = &fast.as_ref().unwrap().next;
    }

    let new_head = slow.as_ref().unwrap().next.take();
    let mut new_tail = &new_head;
    while new_tail.as_ref().unwrap().next.is_some() {
        new_tail = &new_tail.as_ref().unwrap().next;
    }
    new_tail.as_mut().unwrap().next = head;

    new_head
}
}
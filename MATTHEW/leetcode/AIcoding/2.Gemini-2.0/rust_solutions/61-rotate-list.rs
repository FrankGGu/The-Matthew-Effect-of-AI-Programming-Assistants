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
    pub fn rotate_right(head: Option<Box<ListNode>>, k: i32) -> Option<Box<ListNode>> {
        if head.is_none() {
            return None;
        }

        let mut len = 0;
        let mut current = head.as_ref();
        let mut tail = None;
        while let Some(node) = current {
            len += 1;
            tail = Some(node);
            current = node.next.as_ref();
        }

        let k = k % len;
        if k == 0 {
            return head;
        }

        let mut current = head.as_mut();
        for _ in 0..len - k - 1 {
            current = current.unwrap().next.as_mut();
        }

        let mut new_head = current.as_mut().unwrap().next.take();
        tail.unwrap().next = head;
        new_head
    }
}
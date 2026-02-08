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

pub fn reverse_between(head: Option<Box<ListNode>>, left: i32, right: i32) -> Option<Box<ListNode>> {
    if head.is_none() || left == right {
        return head;
    }

    let mut dummy = ListNode::new(0);
    dummy.next = head;
    let mut pre = &mut dummy;

    for _ in 1..left {
        pre = pre.next.as_mut().unwrap();
    }

    let mut curr = pre.next.take();
    let mut prev = None;

    for _ in left..=right {
        if let Some(mut node) = curr {
            curr = node.next.take();
            node.next = prev;
            prev = Some(node);
        }
    }

    pre.next = prev;

    if let Some(mut tail) = pre.next {
        while tail.next.is_some() {
            tail = tail.next.as_mut().unwrap();
        }
        tail.next = curr;
    }

    dummy.next
}
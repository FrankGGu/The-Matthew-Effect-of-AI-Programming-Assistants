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

pub fn remove_nth_from_end(head: Option<Box<ListNode>>, n: i32) -> Option<Box<ListNode>> {
    let mut dummy = Some(Box::new(ListNode::new(0)));
    let mut fast = dummy.clone();
    let mut slow = dummy.clone();
    let mut count = 0;

    while count < n + 1 {
        fast = fast.and_then(|node| node.next);
        count += 1;
    }

    while let Some(node) = fast {
        fast = node.next;
        slow = slow.and_then(|node| node.next);
    }

    if let Some(node) = slow {
        if let Some(mut next) = node.next {
            node.next = next.next;
        }
    }

    dummy.unwrap().next
}
#[derive(Debug, PartialEq, Eq)]
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
    let mut dummy = ListNode::new(0);
    dummy.next = head;
    let mut first = &dummy;
    let mut second = &mut dummy;

    for _ in 0..n {
        if let Some(next) = first.next.as_ref() {
            first = next;
        }
    }

    while first.next.is_some() {
        first = first.next.as_ref().unwrap();
        second = second.next.as_mut().unwrap();
    }

    second.next = second.next.take().and_then(|node| node.next);
    dummy.next
}
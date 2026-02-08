#[derive(Debug, PartialEq, Eq)]
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

pub fn partition(head: Option<Box<ListNode>>, x: i32) -> Option<Box<ListNode>> {
    let mut before_head = ListNode::new(0);
    let mut before = &mut before_head;
    let mut after_head = ListNode::new(0);
    let mut after = &mut after_head;
    let mut current = head;

    while let Some(mut node) = current {
        current = node.next.take();
        if node.val < x {
            before.next = Some(node);
            before = before.next.as_mut().unwrap();
        } else {
            after.next = Some(node);
            after = after.next.as_mut().unwrap();
        }
    }

    after.next = None;
    before.next = after_head.next;

    Some(Box::new(before_head.next.unwrap()))
}
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

pub fn swap_pairs(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
    let mut dummy = ListNode::new(0);
    let mut prev = &mut dummy;
    let mut current = head;

    while let Some(mut node) = current {
        current = node.next.take();
        if let Some(mut next_node) = current {
            current = next_node.next.take();
            prev.next = Some(node);
            node.next = Some(next_node);
            prev = node.next.as_mut().unwrap();
        } else {
            prev.next = Some(node);
            break;
        }
    }

    dummy.next
}
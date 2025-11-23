#[derive(List)]
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

pub fn remove_elements(head: Option<Box<ListNode>>, val: i32) -> Option<Box<ListNode>> {
    let mut dummy = ListNode::new(0);
    let mut current = &mut dummy;
    let mut node = head;

    while let Some(mut n) = node {
        node = n.next.take();
        if n.val != val {
            current.next = Some(n);
            current = current.next.as_mut().unwrap();
        }
    }

    dummy.next
}
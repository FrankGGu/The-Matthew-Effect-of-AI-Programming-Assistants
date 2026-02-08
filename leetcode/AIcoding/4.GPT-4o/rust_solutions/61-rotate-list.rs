#[derive(Clone, PartialEq, Eq)]
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

pub fn rotate_right(head: Option<Box<ListNode>>, k: i32) -> Option<Box<ListNode>> {
    if head.is_none() || k == 0 {
        return head;
    }

    let mut len = 1;
    let mut tail = head.as_ref();

    while let Some(node) = tail {
        if node.next.is_none() {
            break;
        }
        len += 1;
        tail = node.next.as_ref();
    }

    let k = k % len;
    if k == 0 {
        return head;
    }

    let mut prev = None;
    let mut curr = head;

    for _ in 0..len - k {
        prev = curr;
        curr = curr.unwrap().next;
    }

    let new_head = curr;
    if let Some(tail_node) = prev {
        tail_node.next = None;
    }

    let mut tail_node = new_head.as_ref();
    while let Some(node) = tail_node {
        tail_node = node.next.as_ref();
    }

    if let Some(tail_node) = tail_node {
        tail_node.next = head;
    }

    new_head
}
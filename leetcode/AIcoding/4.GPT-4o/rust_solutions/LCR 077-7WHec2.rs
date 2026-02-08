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

pub fn sort_list(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
    if head.is_none() || head.as_ref()?.next.is_none() {
        return head;
    }

    let mut slow = head.clone();
    let mut fast = head.clone();

    while fast.as_ref()?.next.is_some() && fast.as_ref()?.next.as_ref()?.next.is_some() {
        slow = slow.as_ref()?.next.clone();
        fast = fast.as_ref()?.next.as_ref()?.next.clone();
    }

    let mid = slow.clone();
    let left = sort_list(head);
    let right = sort_list(mid);

    merge(left, right)
}

fn merge(l1: Option<Box<ListNode>>, l2: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
    let mut dummy = ListNode::new(0);
    let mut tail = &mut dummy;
    let mut l1 = l1;
    let mut l2 = l2;

    while l1.is_some() && l2.is_some() {
        if l1.as_ref()?.val < l2.as_ref()?.val {
            tail.next = l1;
            tail = tail.next.as_mut().unwrap();
            l1 = tail.next.take();
        } else {
            tail.next = l2;
            tail = tail.next.as_mut().unwrap();
            l2 = tail.next.take();
        }
    }

    tail.next = l1.or(l2);
    dummy.next
}
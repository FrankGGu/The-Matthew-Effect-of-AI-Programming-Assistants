#[derive(PartialEq, Eq, Clone, Debug)]
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

pub fn merge_two_lists(l1: Option<Box<ListNode>>, l2: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
    let mut dummy = ListNode::new(0);
    let mut tail = &mut dummy;

    let mut l1 = l1;
    let mut l2 = l2;

    while l1.is_some() && l2.is_some() {
        let val1 = l1.as_ref().unwrap().val;
        let val2 = l2.as_ref().unwrap().val;

        if val1 < val2 {
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
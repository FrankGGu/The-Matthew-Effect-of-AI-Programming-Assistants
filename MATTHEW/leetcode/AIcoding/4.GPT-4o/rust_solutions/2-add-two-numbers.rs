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

pub fn add_two_numbers(l1: Option<Box<ListNode>>, l2: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
    let mut dummy_head = ListNode::new(0);
    let mut p = l1;
    let mut q = l2;
    let mut current = &mut dummy_head;
    let mut carry = 0;

    while p.is_some() || q.is_some() || carry != 0 {
        let x = p.as_ref().map_or(0, |node| node.val);
        let y = q.as_ref().map_or(0, |node| node.val);
        let sum = x + y + carry;
        carry = sum / 10;
        current.next = Some(Box::new(ListNode::new(sum % 10)));
        current = current.next.as_mut().unwrap();

        if p.is_some() {
            p = p.unwrap().next;
        }
        if q.is_some() {
            q = q.unwrap().next;
        }
    }

    dummy_head.next
}
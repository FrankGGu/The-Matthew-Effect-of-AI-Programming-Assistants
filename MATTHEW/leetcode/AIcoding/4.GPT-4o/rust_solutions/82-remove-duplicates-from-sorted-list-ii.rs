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

pub fn delete_duplicates(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
    let mut dummy = ListNode::new(0);
    let mut prev = &mut dummy;
    let mut current = head;

    while current.is_some() {
        let mut next = current.as_ref().unwrap().next.take();
        let val = current.as_ref().unwrap().val;

        if next.is_some() && next.as_ref().unwrap().val == val {
            while next.is_some() && next.as_ref().unwrap().val == val {
                next = next.unwrap().next;
            }
            current = next;
        } else {
            prev.next = current;
            prev = prev.next.as_mut().unwrap();
            current = next;
        }
    }

    prev.next = None;
    dummy.next
}
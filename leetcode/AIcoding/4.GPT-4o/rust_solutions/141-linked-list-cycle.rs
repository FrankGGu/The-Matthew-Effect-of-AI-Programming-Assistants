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

pub fn has_cycle(head: Option<Box<ListNode>>) -> bool {
    let mut slow = &head;
    let mut fast = &head;

    while let (Some(s), Some(f)) = (slow, fast) {
        slow = &s.next;
        fast = &f.next;
        if let Some(next_fast) = fast {
            fast = &next_fast.next;
        } else {
            return false;
        }
        if std::ptr::eq(s, next_fast) {
            return true;
        }
    }
    false
}
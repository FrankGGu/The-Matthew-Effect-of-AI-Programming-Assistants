impl Solution {

#[derive(PartialEq, Eq, Clone, Debug)]
pub struct ListNode {
    pub val: i32,
    pub next: Option<Box<ListNode>>,
}

impl ListNode {
    #[inline]
    pub fn new(val: i32) -> Self {
        ListNode { next: None, val }
    }
}

pub fn remove_nth_from_end(mut head: Option<Box<ListNode>>, n: i32) -> Option<Box<ListNode>> {
    let mut dummy = Box::new(ListNode { val: 0, next: head });
    let mut fast = &mut dummy;
    let mut slow = &mut dummy;

    for _ in 0..n {
        fast = fast.next.as_mut().unwrap();
    }

    while fast.next.is_some() {
        fast = fast.next.as_mut().unwrap();
        slow = slow.next.as_mut().unwrap();
    }

    slow.next = slow.next.as_mut().unwrap().next.take();

    dummy.next
}
}
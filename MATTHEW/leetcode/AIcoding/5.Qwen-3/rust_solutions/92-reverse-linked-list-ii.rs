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

pub fn reverse_between(head: Option<Box<ListNode>>, left: i32, right: i32) -> Option<Box<ListNode>> {
    let mut dummy = Some(Box::new(ListNode { val: 0, next: head }));
    let mut prev = &mut dummy;

    for _ in 0..left - 1 {
        prev = &mut prev.as_mut().unwrap().next;
    }

    let mut curr = prev.as_mut().unwrap().next.take();
    let mut next = curr.as_ref().unwrap().next.clone();

    for _ in 0..right - left {
        let temp = next.as_ref().unwrap().next.clone();
        next.as_mut().unwrap().next = curr;
        curr = next;
        next = temp;
    }

    prev.as_mut().unwrap().next = curr;
    return dummy.unwrap().next;
}
}
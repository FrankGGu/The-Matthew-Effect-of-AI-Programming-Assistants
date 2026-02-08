#[derive(Debug, PartialEq, Eq)]
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

pub fn reorder_list(head: &mut Option<Box<ListNode>>) {
    if head.is_none() {
        return;
    }

    let mut slow = head.as_ref();
    let mut fast = head.as_ref();

    while fast.is_some() && fast.unwrap().next.is_some() {
        slow = slow.unwrap().next.as_ref();
        fast = fast.unwrap().next.as_ref().unwrap().next.as_ref();
    }

    let mut first_half = head.take();
    let mut second_half = slow.unwrap().next.take();
    slow.unwrap().next = None;

    second_half = reverse_list(second_half);

    let mut first = first_half.as_mut();
    let mut second = second_half;

    while second.is_some() {
        let first_next = first.unwrap().next.take();
        let second_next = second.as_mut().unwrap().next.take();

        first.unwrap().next = second;
        second.as_mut().unwrap().next = first_next;

        first = first_next.as_mut();
        second = second_next;
    }
}

fn reverse_list(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
    let mut prev = None;
    let mut curr = head;

    while curr.is_some() {
        let next_temp = curr.as_mut().unwrap().next.take();
        curr.as_mut().unwrap().next = prev;
        prev = curr;
        curr = next_temp;
    }

    prev
}
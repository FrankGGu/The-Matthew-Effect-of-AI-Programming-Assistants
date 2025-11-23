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
    if head.is_none() || head.as_ref().unwrap().next.is_none() {
        return;
    }

    let mut slow = head.clone();
    let mut fast = head.clone();

    while let Some(ref node) = fast {
        fast = node.next.clone();
        if let Some(ref next_node) = fast {
            fast = next_node.next.clone();
        }
        slow = slow.as_ref().unwrap().next.clone();
    }

    let mut second_half = slow;
    let mut prev = None;
    while let Some(mut node) = second_half {
        second_half = node.next;
        node.next = prev;
        prev = Some(node);
    }

    let mut first_half = head;
    let mut second_half = prev;

    while let (Some(mut first), Some(mut second)) = (first_half, second_half) {
        first_half = first.next.take();
        second_half = second.next.take();

        first.next = Some(second);
        if first_half.is_none() {
            break;
        }
        second.next = first_half;
    }
}
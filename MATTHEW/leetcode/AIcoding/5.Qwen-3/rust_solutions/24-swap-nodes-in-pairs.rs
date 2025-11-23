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

pub fn swap_pairs(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
    let mut dummy = Box::new(ListNode { val: 0, next: head });
    let mut current = &mut dummy.next;

    while let Some(mut node1) = current.take() {
        if let Some(mut node2) = node1.next.take() {
            let next = node2.next.take();
            node1.next = next;
            node2.next = Some(node1);
            *current = Some(node2);
            current = &mut current.as_mut().unwrap().next;
        } else {
            *current = Some(node1);
            break;
        }
    }

    dummy.next
}
}
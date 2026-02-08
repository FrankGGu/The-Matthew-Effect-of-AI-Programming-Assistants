#[derive(ListNode)]
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
    let mut current = head;
    let mut prev = None;

    while let Some(mut node) = current {
        if prev.is_none() || prev.as_ref().unwrap().val != node.val {
            prev = Some(node);
            current = prev.as_mut().unwrap().next.take();
            node.next = current;
            current = Some(node);
        } else {
            current = node.next.take();
        }
    }
    prev
}
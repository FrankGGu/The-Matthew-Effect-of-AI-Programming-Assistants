#[derive(Clone, PartialEq)]
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

pub fn detect_cycle(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
    let (mut slow, mut fast) = (head.as_ref(), head.as_ref());

    while let (Some(slow_node), Some(fast_node)) = (slow, fast) {
        slow = slow_node.next.as_ref();
        fast = fast_node.next.as_ref().and_then(|node| node.next.as_ref());

        if slow.is_none() || fast.is_none() {
            return None;
        }

        if std::ptr::eq(slow_node as *const _, fast_node as *const _) {
            let mut entry = head.as_ref();
            while entry != Some(slow_node) {
                entry = entry.and_then(|node| node.next.as_ref());
                slow = slow.and_then(|node| node.next.as_ref());
            }
            return Some(Box::new(slow_node.clone()));
        }
    }
    None
}
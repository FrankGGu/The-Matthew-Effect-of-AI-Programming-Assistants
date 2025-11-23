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

pub fn middle_node(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
    let (mut slow, mut fast) = (head.as_ref(), head.as_ref());
    while fast.is_some() && fast.unwrap().next.is_some() {
        slow = slow.unwrap().next.as_ref();
        fast = fast.unwrap().next.as_ref().unwrap().next.as_ref();
    }
    slow.map(|node| node.clone())
}
#[derive(PartialEq, Eq, Clone, Debug)]
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

pub fn get_intersection_node(head_a: Option<Box<ListNode>>, head_b: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
    let mut a = head_a;
    let mut b = head_b;

    while a != b {
        a = if let Some(node) = a { node.next } else { head_b.clone() };
        b = if let Some(node) = b { node.next } else { head_a.clone() };
    }

    a
}
#[derive(Debug, PartialEq, Eq)]
pub struct ListNode {
    pub val: i32,
    pub next: Option<Box<ListNode>>,
}

pub fn get_intersection_node(head_a: Option<Box<ListNode>>, head_b: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
    let mut a = &head_a;
    let mut b = &head_b;

    while a.is_some() || b.is_some() {
        if a.is_none() {
            a = &head_b;
        } else {
            a = &a.as_ref()?.next;
        }

        if b.is_none() {
            b = &head_a;
        } else {
            b = &b.as_ref()?.next;
        }

        if a == b {
            return a.clone();
        }
    }

    None
}
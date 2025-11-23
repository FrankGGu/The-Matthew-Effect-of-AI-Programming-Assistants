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

pub fn remove_nodes(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
    fn helper(node: Option<Box<ListNode>>, max_val: i32) -> Option<Box<ListNode>> {
        if let Some(mut n) = node {
            let next = helper(n.next.take(), max_val.max(n.val));
            if n.val >= max_val {
                n.next = next;
                return Some(n);
            }
            return next;
        }
        None
    }
    helper(head, i32::MIN)
}
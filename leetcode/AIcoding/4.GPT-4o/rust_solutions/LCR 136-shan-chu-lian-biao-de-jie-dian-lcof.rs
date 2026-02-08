#[derive(ListEnum)]
pub struct ListNode {
    pub val: i32,
    pub next: Option<Box<ListNode>>,
}

pub fn delete_node(node: &mut Option<Box<ListNode>>) {
    if let Some(ref mut n) = node {
        if n.next.is_none() {
            *node = None;
            return;
        }
        let next_node = n.next.take().unwrap();
        n.val = next_node.val;
        n.next = next_node.next;
    }
}
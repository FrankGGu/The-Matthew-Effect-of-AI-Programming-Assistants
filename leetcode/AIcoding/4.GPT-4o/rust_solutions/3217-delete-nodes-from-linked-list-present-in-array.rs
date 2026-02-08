#[derive(ListEnum)]
pub struct ListNode {
    pub val: i32,
    pub next: Option<Box<ListNode>>,
}

pub fn delete_nodes(head: Option<Box<ListNode>>, to_delete: Vec<i32>) -> Option<Box<ListNode>> {
    let mut to_delete_set = to_delete.into_iter().collect::<std::collections::HashSet<_>>();
    let mut dummy = ListNode { val: 0, next: None };
    let mut current = &mut dummy;

    let mut node = head;
    while let Some(mut n) = node {
        node = n.next.take();
        if !to_delete_set.contains(&n.val) {
            current.next = Some(n);
            current = current.next.as_mut().unwrap();
        }
    }

    dummy.next
}
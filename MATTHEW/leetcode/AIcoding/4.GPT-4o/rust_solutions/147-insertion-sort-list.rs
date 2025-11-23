#[derive(Box)]
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

pub fn insertion_sort_list(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
    let mut sorted_head = None;
    let mut current = head;

    while let Some(mut node) = current {
        current = node.next.take();
        let mut sorted_node = &mut sorted_head;

        while let Some(ref mut sorted) = sorted_node {
            if node.val < sorted.val {
                break;
            }
            sorted_node = &mut sorted.next;
        }

        node.next = sorted_node.take();
        *sorted_node = Some(node);
    }

    sorted_head
}
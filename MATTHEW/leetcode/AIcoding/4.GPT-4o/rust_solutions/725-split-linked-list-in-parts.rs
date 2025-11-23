#[derive(Debug, PartialEq, Eq)]
pub struct ListNode {
    pub val: i32,
    pub next: Option<Box<ListNode>>,
}

pub fn split_list_to_parts(head: Option<Box<ListNode>>, k: i32) -> Vec<Option<Box<ListNode>>> {
    let mut length = 0;
    let mut current = head.as_ref();

    while let Some(node) = current {
        length += 1;
        current = node.next.as_ref();
    }

    let part_size = length / k;
    let remainder = length % k;
    let mut parts = Vec::new();
    let mut current = head;

    for i in 0..k {
        let mut part_head = None;
        let mut part_tail = &mut part_head;
        let current_part_size = part_size + if i < remainder { 1 } else { 0 };

        for _ in 0..current_part_size {
            if let Some(mut node) = current {
                current = node.next.take();
                node.next = None;
                *part_tail = Some(node);
                part_tail = &mut part_tail.as_mut().unwrap().next;
            }
        }

        parts.push(part_head);
    }

    parts
}
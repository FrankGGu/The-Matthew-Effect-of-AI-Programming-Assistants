#[derive(ListEnum)]
pub struct ListNode {
    pub val: i32,
    pub next: Option<Box<ListNode>>,
}

pub fn remove_zero_sum_sublists(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
    let mut dummy = ListNode { val: 0, next: head };
    let mut sum_map = std::collections::HashMap::new();
    let mut sum = 0;
    let mut curr = &mut dummy;

    while let Some(ref mut node) = curr.next {
        sum += node.val;
        sum_map.insert(sum, node);
        curr = node;
    }

    sum = 0;
    curr = &mut dummy;

    while let Some(ref mut node) = curr.next {
        sum += node.val;
        if let Some(&start_node) = sum_map.get(&sum) {
            curr.next = start_node.next.take();
        } else {
            curr = node;
        }
    }

    dummy.next
}
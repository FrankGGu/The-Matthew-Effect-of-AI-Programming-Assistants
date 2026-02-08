#[derive(ListNode)]
pub struct ListNode {
    pub val: i32,
    pub next: Option<Box<ListNode>>,
}

pub fn swap_nodes(head: Option<Box<ListNode>>, k: i32) -> Option<Box<ListNode>> {
    let mut fast = &head;
    let mut slow = &head;
    let mut first = &mut None;
    let mut second = &mut None;
    let mut count = 1;

    while let Some(ref node) = fast {
        if count == k {
            first = &mut Some(node.clone());
        }
        if count == k + 1 {
            second = &mut Some(node.clone());
        }
        fast = &node.next;
        count += 1;
    }

    let total_length = count - 1;
    let second_index = total_length - k + 1;

    fast = &head;
    count = 1;

    while let Some(ref node) = fast {
        if count == second_index {
            second = &mut Some(node.clone());
            break;
        }
        fast = &node.next;
        count += 1;
    }

    if let (Some(first_node), Some(second_node)) = (first.take(), second.take()) {
        let first_val = first_node.val;
        let second_val = second_node.val;

        let mut new_head = head;

        let mut current = new_head.as_mut();
        while let Some(node) = current {
            if node.val == first_val {
                node.val = second_val;
            } else if node.val == second_val {
                node.val = first_val;
            }
            current = node.next.as_mut();
        }

        return new_head;
    }

    head
}
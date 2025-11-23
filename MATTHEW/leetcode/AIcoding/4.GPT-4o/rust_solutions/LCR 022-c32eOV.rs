#[derive(Clone, Copy)]
pub struct ListNode {
    pub val: i32,
    pub next: Option<Box<ListNode>>,
}

pub fn detect_cycle(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
    let mut slow = head.clone();
    let mut fast = head.clone();

    while let Some(ref slow_node) = slow {
        if let Some(ref fast_node) = fast {
            fast = fast_node.next.clone();
            if let Some(ref fast_next) = fast {
                fast = fast_next.next.clone();
            } else {
                return None;
            }

            if slow_node.ptr_eq(fast_node) {
                let mut entry = head.clone();
                while !entry.ptr_eq(slow) {
                    entry = entry.unwrap().next.clone();
                    slow = slow.unwrap().next.clone();
                }
                return entry;
            }
        } else {
            return None;
        }
        slow = slow.unwrap().next.clone();
    }
    None
}
impl Solution {
    pub fn detect_cycle(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        if head.is_none() {
            return None;
        }

        let mut slow_ptr = head.as_ref();
        let mut fast_ptr = head.as_ref();

        let mut cycle_found = false;
        while let (Some(slow_node), Some(fast_node)) = (slow_ptr, fast_ptr) {
            slow_ptr = slow_node.next.as_ref();

            fast_ptr = match fast_node.next.as_ref() {
                Some(next_node) => next_node.next.as_ref(),
                None => break,
            };

            if slow_ptr.is_some() && fast_ptr.is_some() && std::ptr::eq(slow_ptr.unwrap(), fast_ptr.unwrap()) {
                cycle_found = true;
                break;
            }
        }

        if !cycle_found {
            return None;
        }

        let mut ptr1 = head.as_ref();
        let mut ptr2 = slow_ptr;

        while let (Some(node1), Some(node2)) = (ptr1, ptr2) {
            if std::ptr::eq(node1, node2) {
                return Some(node1.clone());
            }
            ptr1 = node1.next.as_ref();
            ptr2 = node2.next.as_ref();
        }
        unreachable!();
    }
}
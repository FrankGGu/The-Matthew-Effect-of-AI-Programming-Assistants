use std::ptr;

impl Solution {
    pub fn has_cycle(head: Option<Box<ListNode>>) -> bool {
        let mut slow = head.as_ref();
        let mut fast = head.as_ref();

        while let Some(f_node_box) = fast {
            if let Some(f_next_node_box) = f_node_box.next.as_ref() {
                // Move slow by one step
                slow = slow.unwrap().next.as_ref();

                // Move fast by two steps
                fast = f_next_node_box.next.as_ref();

                // Compare current positions using raw pointers to check for identity
                // `Option<*const ListNode>`'s PartialEq compares the raw pointers if both are Some.
                let slow_ptr = slow.map(|b| &**b as *const ListNode);
                let fast_ptr = fast.map(|b| &**b as *const ListNode);

                if slow_ptr.is_some() && slow_ptr == fast_ptr {
                    return true;
                }
            } else {
                // fast.next is None, meaning fast cannot move two steps. No cycle.
                return false;
            }
        }
        // fast itself is None, meaning the end of the list was reached. No cycle.
        false
    }
}
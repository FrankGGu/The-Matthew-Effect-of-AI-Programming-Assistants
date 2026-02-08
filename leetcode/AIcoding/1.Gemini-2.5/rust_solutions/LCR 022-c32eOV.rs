impl Solution {
    pub fn detect_cycle(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        let mut slow = head.as_ref();
        let mut fast = head.as_ref();

        let mut cycle_found = false;

        while let Some(f_node) = fast {
            if let Some(s_node) = slow {
                slow = s_node.next.as_ref();
            } else {
                return None;
            }

            if let Some(ff_node) = f_node.next.as_ref() {
                fast = ff_node.next.as_ref();
            } else {
                return None;
            }

            if slow.is_none() || fast.is_none() {
                return None;
            }

            if std::ptr::eq(slow.unwrap().as_ref(), fast.unwrap().as_ref()) {
                cycle_found = true;
                break;
            }
        }

        if !cycle_found {
            return None;
        }

        let mut slow_start = head.as_ref();
        let mut fast_at_meeting = fast;

        while let (Some(s_node), Some(f_node)) = (slow_start, fast_at_meeting) {
            if std::ptr::eq(s_node.as_ref(), f_node.as_ref()) {
                return Some(unsafe { Box::from_raw(s_node.as_ref() as *const ListNode as *mut ListNode) });
            }
            slow_start = s_node.next.as_ref();
            fast_at_meeting = f_node.next.as_ref();
        }

        unreachable!();
    }
}
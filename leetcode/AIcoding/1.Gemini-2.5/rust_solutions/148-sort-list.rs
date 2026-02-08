impl Solution {
    pub fn sort_list(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        if head.is_none() || head.as_ref().unwrap().next.is_none() {
            return head;
        }

        let mut current_head = head;
        let mut slow_ptr = &mut current_head;
        let mut fast_ptr = &mut current_head;
        let mut prev_of_slow: &mut Option<Box<ListNode>> = &mut None;

        while fast_ptr.is_some() && fast_ptr.as_ref().unwrap().next.is_some() {
            prev_of_slow = slow_ptr;
            slow_ptr = &mut slow_ptr.as_mut().unwrap().next;
            fast_ptr = &mut fast_ptr.as_mut().unwrap().next.as_mut().unwrap().next;
        }

        let second_half = prev_of_slow.as_mut().unwrap().next.take();
        let first_half = current_head;

        let sorted_first = Self::sort_list(first_half);
        let sorted_second = Self::sort_list(second_half);

        Self::merge_two_lists(sorted_first, sorted_second)
    }

    fn merge_two_lists(
        l1: Option<Box<ListNode>>,
        l2: Option<Box<ListNode>>,
    ) -> Option<Box<ListNode>> {
        match (l1, l2) {
            (None, None) => None,
            (Some(n), None) => Some(n),
            (None, Some(n)) => Some(n),
            (Some(mut n1), Some(mut n2)) => {
                if n1.val <= n2.val {
                    n1.next = Self::merge_two_lists(n1.next, Some(n2));
                    Some(n1)
                } else {
                    n2.next = Self::merge_two_lists(Some(n1), n2.next);
                    Some(n2)
                }
            }
        }
    }
}
impl Solution {
    pub fn sort_list(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        if head.is_none() || head.as_ref().unwrap().next.is_none() {
            return head;
        }

        // Use a dummy head to simplify splitting logic.
        let mut dummy_head = Some(Box::new(ListNode::new(0)));
        dummy_head.as_mut().unwrap().next = head;

        let mut prev_slow_ptr = &mut dummy_head;
        let mut slow_ptr = &mut dummy_head.as_mut().unwrap().next; // Actual head of the list
        let mut fast_ptr = &dummy_head.as_ref().unwrap().next; // Actual head of the list

        // Find the middle of the list.
        // `prev_slow_ptr` will point to the node just before the middle.
        // `slow_ptr` will point to the head of the second half.
        while fast_ptr.is_some() && fast_ptr.as_ref().unwrap().next.is_some() {
            prev_slow_ptr = prev_slow_ptr.as_mut().unwrap().next.as_mut().unwrap();
            slow_ptr = &mut slow_ptr.as_mut().unwrap().next;
            fast_ptr = &fast_ptr.as_ref().unwrap().next;
            fast_ptr = &fast_ptr.as_ref().unwrap().next;
        }

        // Split the list into two halves.
        // `right_half` takes ownership of the second half.
        // `prev_slow_ptr.next` is set to `None`, terminating the first half.
        let right_half = prev_slow_ptr.as_mut().unwrap().next.take();
        let left_half = dummy_head.unwrap().next; // The first half, now correctly terminated.

        // Recursively sort the two halves.
        let sorted_left = Self::sort_list(left_half);
        let sorted_right = Self::sort_list(right_half);

        // Merge the two sorted halves.
        Self::merge_two_lists(sorted_left, sorted_right)
    }

    // Helper function to merge two sorted linked lists.
    fn merge_two_lists(
        l1: Option<Box<ListNode>>,
        l2: Option<Box<ListNode>>,
    ) -> Option<Box<ListNode>> {
        let mut dummy_head = Some(Box::new(ListNode::new(0)));
        let mut current = &mut dummy_head;

        let mut p1 = l1;
        let mut p2 = l2;

        while p1.is_some() && p2.is_some() {
            let p1_val = p1.as_ref().unwrap().val;
            let p2_val = p2.as_ref().unwrap().val;

            if p1_val <= p2_val {
                current.as_mut().unwrap().next = p1.take();
                current = &mut current.as_mut().unwrap().next;
                p1 = current.as_mut().unwrap().next.take();
            } else {
                current.as_mut().unwrap().next = p2.take();
                current = &mut current.as_mut().unwrap().next;
                p2 = current.as_mut().unwrap().next.take();
            }
        }

        if p1.is_some() {
            current.as_mut().unwrap().next = p1;
        } else if p2.is_some() {
            current.as_mut().unwrap().next = p2;
        }

        dummy_head.unwrap().next
    }
}
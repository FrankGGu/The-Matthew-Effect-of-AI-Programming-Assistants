impl Solution {
    pub fn sort_list(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        fn merge(mut left: Option<Box<ListNode>>, mut right: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
            let mut dummy = ListNode::new(0);
            let mut tail = &mut dummy;

            while left.is_some() && right.is_some() {
                let left_val = left.as_ref().unwrap().val;
                let right_val = right.as_ref().unwrap().val;

                if left_val <= right_val {
                    let next = left.as_mut().unwrap().next.take();
                    tail.next = left;
                    left = next;
                } else {
                    let next = right.as_mut().unwrap().next.take();
                    tail.next = right;
                    right = next;
                }
                tail = tail.next.as_mut().unwrap();
            }

            tail.next = if left.is_some() { left } else { right };
            dummy.next
        }

        fn split(mut head: Option<Box<ListNode>>) -> (Option<Box<ListNode>>, Option<Box<ListNode>>) {
            let mut fast = head.as_ref();
            let mut slow = head.as_ref();
            let mut prev = None;

            while fast.is_some() && fast.as_ref().unwrap().next.is_some() {
                prev = slow;
                slow = slow.unwrap().next.as_ref();
                fast = fast.unwrap().next.as_ref().unwrap().next.as_ref();
            }

            let mut left = head;
            let mut right = None;
            if let Some(prev_node) = prev {
                right = prev_node.next.clone();
                prev_node.next.as_mut().unwrap().next = None;
            }

            (left, right)
        }

        if head.is_none() || head.as_ref().unwrap().next.is_none() {
            return head;
        }

        let (left, right) = split(head);
        let left_sorted = Self::sort_list(left);
        let right_sorted = Self::sort_list(right);

        merge(left_sorted, right_sorted)
    }
}
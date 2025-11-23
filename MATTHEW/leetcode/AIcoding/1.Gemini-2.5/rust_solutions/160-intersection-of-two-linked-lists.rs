impl Solution {
    pub fn get_intersection_node(headA: Option<Box<ListNode>>, headB: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        fn get_len(mut head: &Option<Box<ListNode>>) -> usize {
            let mut len = 0;
            while let Some(node) = head {
                len += 1;
                head = &node.next;
            }
            len
        }

        let len_a = get_len(&headA);
        let len_b = get_len(&headB);

        let mut current_a = headA;
        let mut current_b = headB;

        if len_a > len_b {
            for _ in 0..(len_a - len_b) {
                current_a = current_a.and_then(|node| node.next);
            }
        } else if len_b > len_a {
            for _ in 0..(len_b - len_a) {
                current_b = current_b.and_then(|node| node.next);
            }
        }

        while current_a.is_some() && current_b.is_some() {
            let raw_a = current_a.as_ref().map(|node| &**node as *const ListNode);
            let raw_b = current_b.as_ref().map(|node| &**node as *const ListNode);

            if raw_a == raw_b {
                return current_a;
            }

            current_a = current_a.and_then(|node| node.next);
            current_b = current_b.and_then(|node| node.next);
        }

        None
    }
}
impl Solution {
    pub fn rotate_right(head: Option<Box<ListNode>>, k: i32) -> Option<Box<ListNode>> {
        if head.is_none() || k == 0 {
            return head;
        }

        let mut actual_head = head.unwrap();

        let mut len = 1;
        let mut current_node = &mut actual_head;
        while let Some(next_node) = current_node.next.as_mut() {
            len += 1;
            current_node = next_node;
        }

        let k_actual = k % len;
        if k_actual == 0 {
            return Some(actual_head);
        }

        current_node.next = Some(actual_head);

        let steps_to_new_tail = len - k_actual;

        let mut circle_head = current_node.next.as_mut().unwrap();
        let mut new_tail_candidate = circle_head;
        for _ in 0..(steps_to_new_tail - 1) {
            new_tail_candidate = new_tail_candidate.next.as_mut().unwrap();
        }

        let new_head = new_tail_candidate.next.take();

        new_head
    }
}
impl Solution {
    pub fn reverse_between(head: Option<Box<ListNode>>, left: i32, right: i32) -> Option<Box<ListNode>> {
        if head.is_none() || left == right {
            return head;
        }

        let mut dummy_head = Some(Box::new(ListNode { val: 0, next: head }));
        let mut current = &mut dummy_head;

        for _ in 0..(left - 1) {
            current = &mut current.as_mut().unwrap().next;
        }

        let mut start_node_of_segment = current.as_mut().unwrap().next.take();

        let mut reversed_head = None;
        let mut post_right_node = None;

        for _ in 0..(right - left + 1) {
            let mut node_to_reverse = start_node_of_segment.take().unwrap();
            let mut next_node_in_original_list = node_to_reverse.next.take();

            node_to_reverse.next = reversed_head;
            reversed_head = Some(node_to_reverse);

            start_node_of_segment = next_node_in_original_list;
        }

        post_right_node = start_node_of_segment;

        current.as_mut().unwrap().next = reversed_head;

        let mut tail_of_reversed_segment_ptr = &mut current.as_mut().unwrap().next;
        for _ in 0..(right - left) {
            tail_of_reversed_segment_ptr = &mut tail_of_reversed_segment_ptr.as_mut().unwrap().next;
        }

        tail_of_reversed_segment_ptr.as_mut().unwrap().next = post_right_node;

        dummy_head.unwrap().next
    }
}
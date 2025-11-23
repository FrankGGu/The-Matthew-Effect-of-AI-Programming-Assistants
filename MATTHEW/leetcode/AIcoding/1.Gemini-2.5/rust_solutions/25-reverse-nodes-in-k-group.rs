impl Solution {
    pub fn reverse_k_group(head: Option<Box<ListNode>>, k: i32) -> Option<Box<ListNode>> {
        let mut current = head;
        let mut count = 0;
        let mut check_ptr = &mut current;

        while let Some(node) = check_ptr {
            count += 1;
            if count == k {
                break;
            }
            check_ptr = &mut node.next;
        }

        if count < k {
            return current;
        }

        let mut prev = None;
        let mut current_node = current;
        let mut next_node_temp;
        let mut i = 0;

        while i < k {
            let mut node = current_node.unwrap();
            next_node_temp = node.next.take();
            node.next = prev.take();
            prev = Some(node);
            current_node = next_node_temp;
            i += 1;
        }

        let mut new_head_of_k_group = prev;
        let head_of_next_segment = current_node;

        let mut tail_of_reversed_k_group = new_head_of_k_group.as_mut().unwrap();
        while let Some(ref mut node) = tail_of_reversed_k_group.next {
            tail_of_reversed_k_group = node;
        }

        tail_of_reversed_k_group.next = Solution::reverse_k_group(head_of_next_segment, k);

        new_head_of_k_group
    }
}
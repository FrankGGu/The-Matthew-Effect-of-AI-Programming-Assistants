impl Solution {
    pub fn swap_nodes(head: Option<Box<ListNode>>, k: i32) -> Option<Box<ListNode>> {
        let mut dummy_head = Some(Box::new(ListNode { val: 0, next: head }));

        let mut curr_ptr = &mut dummy_head.as_mut().unwrap().next;
        let mut nodes_vec: Vec<&mut ListNode> = Vec::new();

        while let Some(node_box) = curr_ptr {
            nodes_vec.push(&mut **node_box);
            curr_ptr = &mut node_box.next;
        }

        let len = nodes_vec.len();
        if len == 0 {
            return dummy_head.unwrap().next;
        }

        let k_from_start_idx = (k - 1) as usize;
        let k_from_end_idx = len - (k as usize);

        let temp_val = nodes_vec[k_from_start_idx].val;
        nodes_vec[k_from_start_idx].val = nodes_vec[k_from_end_idx].val;
        nodes_vec[k_from_end_idx].val = temp_val;

        dummy_head.unwrap().next
    }
}
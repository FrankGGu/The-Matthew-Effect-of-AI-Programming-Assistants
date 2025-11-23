use std::collections::HashSet;

impl Solution {
    pub fn delete_nodes_from_linked_list_present_in_array(head: Option<Box<ListNode>>, nums: Vec<i32>) -> Option<Box<ListNode>> {
        let to_delete: HashSet<i32> = nums.into_iter().collect();

        let mut dummy_head = Some(Box::new(ListNode::new(0)));
        let mut current_ptr = &mut dummy_head;

        while let Some(mut node) = current_ptr.as_mut().unwrap().next.take() {
            if to_delete.contains(&node.val) {
                current_ptr.as_mut().unwrap().next = node.next;
            } else {
                current_ptr.as_mut().unwrap().next = Some(node);
                current_ptr = &mut current_ptr.as_mut().unwrap().next;
            }
        }

        dummy_head.unwrap().next
    }
}
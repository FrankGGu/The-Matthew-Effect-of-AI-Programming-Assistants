impl Solution {
    pub fn insertion_sort_list(mut head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        let mut dummy_head = ListNode::new(0); // Dummy node to simplify insertions at the beginning

        // Iterate through the original list, taking one node at a time
        while let Some(mut current_node) = head.take() {
            // Detach the rest of the original list from current_node
            head = current_node.next.take(); 

            // Find the insertion point in the sorted list (starting from dummy_head)
            // `prev_ptr` is a mutable reference to an Option<Box<ListNode>>.
            // It will traverse the sorted list and stop at the `next` field
            // where `current_node` should be inserted.
            let mut prev_ptr = &mut dummy_head.next;

            // Traverse the sorted list until we find a node whose value is
            // greater than or equal to `current_node.val`, or reach the end.
            while let Some(ref mut sorted_node) = prev_ptr {
                if sorted_node.val < current_node.val {
                    prev_ptr = &mut sorted_node.next;
                } else {
                    break; // Found the insertion point
                }
            }

            // Insert `current_node` into the sorted list:
            // 1. `current_node.next` should point to whatever `prev_ptr` currently points to.
            //    We use `take()` to get the value out of `prev_ptr` and set `prev_ptr` to None.
            current_node.next = prev_ptr.take();

            // 2. `prev_ptr` (which is now None) should point to `current_node`.
            //    We put `Some(current_node)` back into `prev_ptr`.
            *prev_ptr = Some(current_node);
        }

        // The sorted list starts after the dummy node
        dummy_head.next
    }
}
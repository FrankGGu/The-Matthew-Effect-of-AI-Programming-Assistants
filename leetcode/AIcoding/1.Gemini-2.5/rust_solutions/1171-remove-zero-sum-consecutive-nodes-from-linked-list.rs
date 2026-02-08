use std::collections::HashMap;

#[derive(PartialEq, Eq, Clone, Debug)]
pub struct ListNode {
    pub val: i32,
    pub next: Option<Box<ListNode>>,
}

impl ListNode {
    #[inline]
    fn new(val: i32) -> Self {
        ListNode { next: None, val }
    }
}

struct Solution;

impl Solution {
    pub fn remove_zero_sum_sublists(
        head: Option<Box<ListNode>>,
    ) -> Option<Box<ListNode>> {
        let mut dummy_head = Box::new(ListNode::new(0));
        dummy_head.next = head;

        // map stores (prefix_sum, raw_pointer_to_the_node_that_achieves_that_sum)
        let mut map: HashMap<i32, *mut ListNode> = HashMap::new();
        let mut current_sum = 0;

        // current_ptr will always point to the node *before* the one whose value we are currently adding to the sum.
        // Initially, it points to the dummy head.
        let mut current_ptr: *mut ListNode = &mut *dummy_head;

        // Insert initial state: sum 0 at the dummy head.
        // This allows removing a prefix of the list that sums to zero.
        map.insert(0, current_ptr);

        // Iterate through the list.
        // `current_ptr` will be advanced to `node_to_process_ptr` if no zero-sum sublist is found.
        // If a zero-sum sublist is found, `current_ptr` will be reset to `prev_node_ptr`
        // to re-evaluate the list from that point.
        loop {
            // Get a mutable raw pointer to the next node.
            // This is unsafe because we are dereferencing a raw pointer (`current_ptr`)
            // and potentially creating a new raw pointer from its `next` field.
            let next_node_opt = unsafe { (*current_ptr).next.as_mut().map(|b| &mut **b) };

            // If there's no next node, we've reached the end of the list.
            if next_node_opt.is_none() {
                break;
            }

            let node_to_process_ptr = next_node_opt.unwrap();

            // Add the current node's value to the running sum.
            // This is unsafe because we are dereferencing `node_to_process_ptr`.
            current_sum += unsafe { (*node_to_process_ptr).val };

            if let Some(&prev_node_ptr) = map.get(&current_sum) {
                // A zero-sum sublist is found.
                // It starts AFTER `prev_node_ptr` and ends AT `node_to_process_ptr`.
                // We need to remove all intermediate prefix sums from the map.

                // `node_to_remove_ptr` will traverse from `prev_node_ptr.next` up to `node_to_process_ptr` (exclusive).
                // `sum_at_node_to_remove` tracks the prefix sum at `node_to_remove_ptr`.
                // It starts with `current_sum` (which is the sum up to `prev_node_ptr`).
                let mut node_to_remove_ptr = unsafe {
                    (*prev_node_ptr)
                        .next
                        .as_mut()
                        .map(|b| &mut **b)
                        .unwrap_or(std::ptr::null_mut())
                };
                let mut sum_at_node_to_remove = current_sum;

                // Remove all sums from the map that correspond to nodes within the zero-sum segment.
                // This is unsafe due to dereferencing `node_to_remove_ptr`.
                while !node_to_remove_ptr.is_null() && node_to_remove_ptr != node_to_process_ptr {
                    sum_at_node_to_remove += unsafe { (*node_to_remove_ptr).val };
                    map.remove(&sum_at_node_to_remove);
                    node_to_remove_ptr = unsafe {
                        (*node_to_remove_ptr)
                            .next
                            .as_mut()
                            .map(|b| &mut **b)
                            .unwrap_or(std::ptr::null_mut())
                    };
                }

                // Link `prev_node_ptr.next` to `node_to_process_ptr.next`, effectively removing the sublist.
                // This is unsafe due to dereferencing `prev_node_ptr` and `node_to_process_ptr`.
                unsafe {
                    (*prev_node_ptr).next = (*node_to_process_ptr).next.take();
                }

                // Rewind `current_ptr` to `prev_node_ptr`.
                // The next iteration will then correctly advance from `prev_node_ptr`'s new `next`.
                current_ptr = prev_node_ptr;
            } else {
                // No zero-sum sublist ending at `node_to_process_ptr` found.
                // Add `current_sum` and `node_to_process_ptr` to the map.
                map.insert(current_sum, node_to_process_ptr);

                // Advance `current_ptr` to the node we just processed.
                current_ptr = node_to_process_ptr;
            }
        }

        // Return the modified list, skipping the dummy head.
        dummy_head.next
    }
}
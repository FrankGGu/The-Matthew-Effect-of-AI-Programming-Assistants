#[derive(PartialEq, Eq, Clone, Debug)]
pub struct ListNode {
  pub val: i32,
  pub next: Option<Box<ListNode>>
}

impl ListNode {
  #[inline]
  pub fn new(val: i32) -> Self {
    ListNode {
      next: None,
      val
    }
  }
}

struct Solution;

impl Solution {
    pub fn merge_nodes(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        let mut dummy_head = Some(Box::new(ListNode::new(0)));
        let mut current_new_node_ptr = &mut dummy_head;

        let mut current_sum = 0;
        let mut current_old_node = head;

        // Skip the initial zero node as per problem description
        if let Some(node) = current_old_node {
            current_old_node = node.next;
        } else {
            return None; // Should not happen based on problem constraints
        }

        while let Some(mut node) = current_old_node {
            if node.val == 0 {
                // End of a segment of non-zero numbers
                if current_sum > 0 {
                    // Create a new node with the sum and append it to the new list
                    *current_new_node_ptr = Some(Box::new(ListNode::new(current_sum)));
                    // Move the pointer to the next field of the newly added node
                    current_new_node_ptr = &mut current_new_node_ptr.as_mut().unwrap().next;
                }
                current_sum = 0; // Reset sum for the next segment
            } else {
                current_sum += node.val;
            }
            current_old_node = node.next; // Move to the next node in the original list
        }

        // The dummy_head's next field contains the actual merged list
        dummy_head.unwrap().next
    }
}
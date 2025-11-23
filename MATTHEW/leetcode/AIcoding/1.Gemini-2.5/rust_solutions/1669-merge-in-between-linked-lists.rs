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

impl Solution {
    pub fn merge_in_between(mut list1: Option<Box<ListNode>>, a: i32, b: i32, list2: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        let mut dummy_head = Some(Box::new(ListNode { val: 0, next: list1 }));
        let mut current = dummy_head.as_mut();

        // Traverse to the node *before* index 'a'
        // 'current' will point to the node at index 'a-1' (or dummy_head if a=0)
        for _ in 0..a {
            if let Some(node) = current {
                current = node.next.as_mut();
            } else {
                // This case should not be reached given problem constraints
                return None;
            }
        }

        // 'node_before_a' is the node at index 'a-1'.
        // We take its 'next' pointer, which is the start of the segment to be removed.
        let mut node_before_a = current.unwrap();
        let mut segment_to_remove_start = node_before_a.next.take();

        // Traverse the 'segment_to_remove_start' to find the node at index 'b'.
        // 'current_b' will point to the node at index 'b' within this segment.
        let mut current_b = segment_to_remove_start.as_mut();
        for _ in a..b { // Iterate from index 'a' up to 'b-1' (total b-a iterations)
            if let Some(node) = current_b {
                current_b = node.next.as_mut();
            } else {
                // This case should not be reached given problem constraints
                return None;
            }
        }

        // 'node_after_b' is the segment of list1 that comes *after* index 'b'.
        let node_after_b = current_b.unwrap().next.take();

        // Connect 'node_before_a.next' to the head of 'list2'.
        node_before_a.next = list2;

        // Find the tail of 'list2' and connect it to 'node_after_b'.
        let mut current_list2_tail = node_before_a.next.as_mut();

        // If list2 was empty, node_before_a.next is now None.
        // In this case, we connect node_before_a.next directly to node_after_b.
        if current_list2_tail.is_none() {
            node_before_a.next = node_after_b;
        } else {
            // Traverse to the end of list2
            while let Some(node) = current_list2_tail {
                if node.next.is_none() {
                    // Found the tail of list2
                    node.next = node_after_b;
                    break;
                }
                current_list2_tail = node.next.as_mut();
            }
        }

        // The modified list starts after the dummy head.
        dummy_head.unwrap().next
    }
}
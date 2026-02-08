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
    pub fn reorder_list(head: &mut Option<Box<ListNode>>) {
        if head.is_none() || head.as_ref().unwrap().next.is_none() {
            return;
        }

        // 1. Find the middle of the list and split it into two halves
        let mut first_half_head = head.take(); 

        let mut slow_ptr = first_half_head.as_mut();
        let mut fast_ptr = first_half_head.as_mut();
        let mut prev_slow_ptr: Option<&mut Box<ListNode>> = None;

        while fast_ptr.is_some() && fast_ptr.as_ref().unwrap().next.is_some() {
            prev_slow_ptr = slow_ptr.take();
            slow_ptr = prev_slow_ptr.as_mut().unwrap().next.as_mut();
            fast_ptr = fast_ptr.unwrap().next.as_mut().unwrap().next.as_mut();
        }

        // `prev_slow_ptr` now points to the last node of the first half.
        // `slow_ptr` points to the head of the second half.

        // Break the link between the two halves
        let mut second_half_head = prev_slow_ptr.unwrap().next.take();

        // `first_half_head` now contains `L0 -> ... -> L_middle`.
        // `second_half_head` now contains `L_middle+1 -> ... -> Ln`.

        // 2. Reverse the second half
        let mut prev = None;
        let mut curr = second_half_head;
        while let Some(mut node) = curr.take() {
            let next_temp = node.next.take();
            node.next = prev.take();
            prev = Some(node);
            curr = next_temp;
        }
        let mut reversed_second_half = prev;

        // 3. Merge the two halves
        // `first_half_head` is `L0 -> L1 -> ...`
        // `reversed_second_half` is `Ln -> Ln-1 -> ...`

        let mut p1 = first_half_head;
        let mut p2 = reversed_second_half;

        // `current_node_ref` will be used to build the merged list by modifying `head` parameter.
        let mut current_node_ref = head; 

        while p1.is_some() && p2.is_some() {
            let mut node1 = p1.take().unwrap();
            let mut node2 = p2.take().unwrap();

            let next1 = node1.next.take(); // Store L1
            let next2 = node2.next.take(); // Store Ln-1

            node1.next = Some(node2); // L0 -> Ln
            node1.next.as_mut().unwrap().next = next1; // Ln -> L1

            // Attach the current merged segment (L0 -> Ln -> L1) to the main list
            current_node_ref.replace(node1);
            // Advance `current_node_ref` to the next `next` field to be filled (which is L1's next field)
            current_node_ref = &mut current_node_ref.as_mut().unwrap().next.as_mut().unwrap().next;

            p1 = next1; // Move to L2
            p2 = next2; // Move to Ln-2
        }

        // If there's any remaining node in the first half (for odd length lists)
        if p1.is_some() {
            current_node_ref.replace(p1.unwrap());
        }
    }
}
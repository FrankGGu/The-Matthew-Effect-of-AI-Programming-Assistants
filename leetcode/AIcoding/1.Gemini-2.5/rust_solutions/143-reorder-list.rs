#[derive(PartialEq, Eq, Clone, Debug)]
pub struct ListNode {
  pub val: i32,
  pub next: Option<Box<ListNode>>
}

impl ListNode {
  #[inline]
  fn new(val: i32) -> Self {
    ListNode {
      next: None,
      val
    }
  }
}

impl Solution {
    pub fn reorder_list(head: &mut Option<Box<ListNode>>) {
        // Handle empty list or list with only one node
        if head.is_none() || head.as_ref().unwrap().next.is_none() {
            return;
        }

        // Take ownership of the head node
        let mut head1 = head.take();

        // 1. Find the middle of the list and split it into two halves.
        // `slow_ptr` will point to the last node of the first half.
        // `fast_ptr` will reach the end.
        let mut slow_ptr = &mut head1;
        let mut fast_ptr = &mut head1;

        while fast_ptr.as_ref().unwrap().next.is_some() && fast_ptr.as_ref().unwrap().next.as_ref().unwrap().next.is_some() {
            slow_ptr = &mut slow_ptr.as_mut().unwrap().next;
            fast_ptr = &mut fast_ptr.as_mut().unwrap().next.as_mut().unwrap().next;
        }

        // `slow_ptr` now points to the last node of the first half.
        // Split the list into two. `head2` will be the second half.
        let mut head2 = slow_ptr.as_mut().unwrap().next.take();
        // The link between the first and second half is now broken.

        // 2. Reverse the second half (`head2`).
        let mut prev = None;
        let mut current = head2;
        while let Some(mut node) = current.take() {
            let next_temp = node.next.take();
            node.next = prev.take();
            prev = Some(node);
            current = next_temp;
        }
        let mut head2_reversed = prev; // `head2_reversed` is now the reversed second half.

        // 3. Merge the two halves alternately.
        // `head1` is the first half.
        // `head2_reversed` is the reversed second half.
        let mut dummy_head = Some(Box::new(ListNode::new(0)));
        let mut tail = dummy_head.as_mut().unwrap();

        while head1.is_some() && head2_reversed.is_some() {
            // Append node from `head1`
            if let Some(mut node1) = head1.take() {
                head1 = node1.next.take(); // Advance `head1`
                tail.next = Some(node1);
                tail = tail.next.as_mut().unwrap();
            }

            // Append node from `head2_reversed`
            if let Some(mut node2) = head2_reversed.take() {
                head2_reversed = node2.next.take(); // Advance `head2_reversed`
                tail.next = Some(node2);
                tail = tail.next.as_mut().unwrap();
            }
        }

        // If `head1` still has remaining nodes (occurs if the original list had an odd number of nodes)
        if head1.is_some() {
            tail.next = head1.take();
        }

        // Update the original `head` reference with the reordered list.
        *head = dummy_head.unwrap().next;
    }
}
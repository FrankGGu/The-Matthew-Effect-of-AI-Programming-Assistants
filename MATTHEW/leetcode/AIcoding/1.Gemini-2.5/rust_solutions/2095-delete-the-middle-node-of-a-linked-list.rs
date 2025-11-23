impl Solution {
    pub fn delete_middle(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        if head.is_none() || head.as_ref().unwrap().next.is_none() {
            return None;
        }

        let mut dummy_head = Some(Box::new(ListNode { val: 0, next: head }));
        let mut slow = &mut dummy_head;
        let mut fast = &mut dummy_head;

        // Move fast pointer two steps at a time, slow pointer one step at a time.
        // When fast reaches the end (or one before the end), slow will be at the node
        // *before* the middle node.
        while fast.as_ref().unwrap().next.is_some() && fast.as_ref().unwrap().next.as_ref().unwrap().next.is_some() {
            slow = &mut slow.as_mut().unwrap().next;
            fast = &mut fast.as_mut().unwrap().next.as_mut().unwrap().next;
        }

        // At this point, `slow` is `&mut Option<Box<ListNode>>` which is the `next` field
        // of the node *before* the middle node.
        // For example, if the list (including dummy) is 0 -> A -> B -> C -> D, and B is the middle node.
        // `slow` will point to `A.next` (which is `Some(Box(B))`).
        // We want to delete `B`. So we need to set `A.next = C`.
        // `slow.as_mut().unwrap().next` is `Some(Box(B))`.
        // `slow.as_mut().unwrap().next.as_mut().unwrap().next` is `Some(Box(C))`.
        // By taking `C` and assigning it to `A.next`, `B` is effectively unlinked.
        slow.as_mut().unwrap().next = slow.as_mut().unwrap().next.as_mut().unwrap().next.take();

        dummy_head.unwrap().next
    }
}
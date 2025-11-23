impl Solution {
    pub fn remove_nth_from_end(head: Option<Box<ListNode>>, n: i32) -> Option<Box<ListNode>> {
        let mut dummy = Some(Box::new(ListNode { val: 0, next: head }));
        let mut fast = dummy.clone();
        let mut slow = dummy.as_mut();

        for _ in 0..n {
            fast = fast.unwrap().next;
        }

        while fast.is_some() && fast.as_ref().unwrap().next.is_some() {
            fast = fast.unwrap().next;
            slow = slow.unwrap().next.as_mut();
        }

        if let Some(mut slow_node) = slow {
            slow_node.next = slow_node.next.take().and_then(|node| node.next);
        }

        dummy.unwrap().next
    }
}
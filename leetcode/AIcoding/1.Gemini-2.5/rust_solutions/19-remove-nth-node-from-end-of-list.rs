impl Solution {
    pub fn remove_nth_from_end(head: Option<Box<ListNode>>, n: i32) -> Option<Box<ListNode>> {
        let mut dummy = Some(Box::new(ListNode { val: 0, next: head }));
        let mut fast = &mut dummy;
        let mut slow = &mut dummy;

        for _ in 0..n {
            fast = &mut fast.as_mut().unwrap().next;
        }

        while fast.as_mut().unwrap().next.is_some() {
            fast = &mut fast.as_mut().unwrap().next;
            slow = &mut slow.as_mut().unwrap().next;
        }

        let node_to_remove = slow.as_mut().unwrap().next.take();

        if let Some(mut removed_node) = node_to_remove {
            slow.as_mut().unwrap().next = removed_node.next.take();
        }

        dummy.unwrap().next
    }
}
impl Solution {
    pub fn training_plan(head: Option<Box<ListNode>>, cnt: i32) -> Option<Box<ListNode>> {
        let mut fast = head.as_ref();
        let mut slow = head.as_ref();

        for _ in 0..cnt {
            fast = fast.and_then(|node| node.next.as_ref());
        }

        while let Some(node) = fast {
            fast = node.next.as_ref();
            slow = slow.and_then(|node| node.next.as_ref());
        }

        slow.cloned()
    }
}
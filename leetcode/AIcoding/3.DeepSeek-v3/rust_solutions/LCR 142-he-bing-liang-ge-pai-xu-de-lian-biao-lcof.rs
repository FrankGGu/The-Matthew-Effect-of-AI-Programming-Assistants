impl Solution {
    pub fn trainning_plan(mut l1: Option<Box<ListNode>>, mut l2: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        let mut dummy = ListNode::new(0);
        let mut tail = &mut dummy;

        while let (Some(node1), Some(node2)) = (l1.as_ref(), l2.as_ref()) {
            if node1.val < node2.val {
                tail.next = l1.take();
                tail = tail.next.as_mut().unwrap();
                l1 = tail.next.take();
            } else {
                tail.next = l2.take();
                tail = tail.next.as_mut().unwrap();
                l2 = tail.next.take();
            }
        }

        tail.next = if l1.is_some() { l1 } else { l2 };
        dummy.next
    }
}
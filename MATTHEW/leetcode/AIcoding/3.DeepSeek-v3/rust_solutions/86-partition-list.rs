impl Solution {
    pub fn partition(head: Option<Box<ListNode>>, x: i32) -> Option<Box<ListNode>> {
        let mut less_head = ListNode::new(0);
        let mut greater_head = ListNode::new(0);
        let mut less_tail = &mut less_head;
        let mut greater_tail = &mut greater_head;

        let mut current = head;

        while let Some(mut node) = current {
            current = node.next.take();
            if node.val < x {
                less_tail.next = Some(node);
                less_tail = less_tail.next.as_mut().unwrap();
            } else {
                greater_tail.next = Some(node);
                greater_tail = greater_tail.next.as_mut().unwrap();
            }
        }

        less_tail.next = greater_head.next;
        less_head.next
    }
}
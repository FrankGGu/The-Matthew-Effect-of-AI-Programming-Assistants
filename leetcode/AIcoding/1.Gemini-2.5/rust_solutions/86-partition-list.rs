impl Solution {
    pub fn partition(head: Option<Box<ListNode>>, x: i32) -> Option<Box<ListNode>> {
        let mut less_dummy = ListNode::new(0);
        let mut greater_dummy = ListNode::new(0);

        let mut less_curr = &mut less_dummy;
        let mut greater_curr = &mut greater_dummy;

        let mut current_node = head;

        while let Some(mut node) = current_node.take() {
            current_node = node.next.take();

            if node.val < x {
                less_curr.next = Some(node);
                less_curr = less_curr.next.as_mut().unwrap();
            } else {
                greater_curr.next = Some(node);
                greater_curr = greater_curr.next.as_mut().unwrap();
            }
        }

        less_curr.next = greater_dummy.next;

        less_dummy.next
    }
}
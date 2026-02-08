impl Solution {
    pub fn merge_nodes(mut head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        let mut dummy = ListNode::new(0);
        let mut tail = &mut dummy;
        let mut current = head.as_ref();
        let mut sum = 0;

        while let Some(node) = current {
            if node.val == 0 {
                if sum != 0 {
                    tail.next = Some(Box::new(ListNode::new(sum)));
                    tail = tail.next.as_mut().unwrap();
                    sum = 0;
                }
            } else {
                sum += node.val;
            }
            current = node.next.as_ref();
        }

        dummy.next
    }
}
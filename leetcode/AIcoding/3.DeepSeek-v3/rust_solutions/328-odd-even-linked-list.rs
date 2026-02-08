impl Solution {
    pub fn odd_even_list(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        let mut head = head;
        let mut odd_head = ListNode::new(0);
        let mut even_head = ListNode::new(0);
        let mut odd_tail = &mut odd_head;
        let mut even_tail = &mut even_head;
        let mut is_odd = true;

        while let Some(mut node) = head {
            head = node.next.take();
            if is_odd {
                odd_tail.next = Some(node);
                odd_tail = odd_tail.next.as_mut().unwrap();
            } else {
                even_tail.next = Some(node);
                even_tail = even_tail.next.as_mut().unwrap();
            }
            is_odd = !is_odd;
        }

        odd_tail.next = even_head.next;
        odd_head.next
    }
}
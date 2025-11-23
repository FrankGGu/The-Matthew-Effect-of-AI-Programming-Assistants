impl Solution {
    pub fn add_two_numbers(l1: Option<Box<ListNode>>, l2: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        let mut dummy = ListNode::new(0);
        let mut current = &mut dummy;
        let mut carry = 0;
        let mut p = l1;
        let mut q = l2;

        while p.is_some() || q.is_some() || carry != 0 {
            let sum = carry 
                + p.as_ref().map_or(0, |node| node.val)
                + q.as_ref().map_or(0, |node| node.val);
            carry = sum / 10;
            current.next = Some(Box::new(ListNode::new(sum % 10)));
            current = current.next.as_mut().unwrap();
            p = p.and_then(|node| node.next);
            q = q.and_then(|node| node.next);
        }

        dummy.next
    }
}
impl Solution {
    pub fn add_two_numbers(l1: Option<Box<ListNode>>, l2: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        let mut dummy_head = Box::new(ListNode::new(0));
        let mut current = &mut dummy_head;
        let mut carry = 0;
        let mut p1 = l1;
        let mut p2 = l2;

        while p1.is_some() || p2.is_some() || carry != 0 {
            let mut val1 = 0;
            if let Some(node) = p1.take() {
                val1 = node.val;
                p1 = node.next;
            }

            let mut val2 = 0;
            if let Some(node) = p2.take() {
                val2 = node.val;
                p2 = node.next;
            }

            let sum_val = val1 + val2 + carry;
            carry = sum_val / 10;
            let digit = sum_val % 10;

            current.next = Some(Box::new(ListNode::new(digit)));
            current = current.next.as_mut().unwrap();
        }

        dummy_head.next
    }
}
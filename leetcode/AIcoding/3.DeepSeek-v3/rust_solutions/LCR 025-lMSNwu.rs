impl Solution {
    pub fn add_two_numbers(l1: Option<Box<ListNode>>, l2: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        let mut stack1 = Vec::new();
        let mut stack2 = Vec::new();

        let mut p1 = l1.as_ref();
        while let Some(node) = p1 {
            stack1.push(node.val);
            p1 = node.next.as_ref();
        }

        let mut p2 = l2.as_ref();
        while let Some(node) = p2 {
            stack2.push(node.val);
            p2 = node.next.as_ref();
        }

        let mut carry = 0;
        let mut head = None;

        while !stack1.is_empty() || !stack2.is_empty() || carry != 0 {
            let sum = carry 
                + stack1.pop().unwrap_or(0) 
                + stack2.pop().unwrap_or(0);
            carry = sum / 10;
            let mut node = ListNode::new(sum % 10);
            node.next = head;
            head = Some(Box::new(node));
        }

        head
    }
}
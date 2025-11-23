impl Solution {
    pub fn add_two_numbers(l1: Option<Box<ListNode>>, l2: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        let mut s1: Vec<i32> = Vec::new();
        let mut s2: Vec<i32> = Vec::new();

        let mut current = l1;
        while let Some(node) = current {
            s1.push(node.val);
            current = node.next;
        }

        let mut current = l2;
        while let Some(node) = current {
            s2.push(node.val);
            current = node.next;
        }

        let mut head: Option<Box<ListNode>> = None;
        let mut carry = 0;

        while !s1.is_empty() || !s2.is_empty() || carry != 0 {
            let mut sum = carry;
            if let Some(val) = s1.pop() {
                sum += val;
            }
            if let Some(val) = s2.pop() {
                sum += val;
            }

            carry = sum / 10;
            let digit = sum % 10;

            let mut new_node = Box::new(ListNode::new(digit));
            new_node.next = head;
            head = Some(new_node);
        }

        head
    }
}
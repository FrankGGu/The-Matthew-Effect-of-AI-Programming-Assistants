impl Solution {
    pub fn double_it(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        let mut head = head;
        let mut stack = Vec::new();
        let mut current = &head;
        while let Some(node) = current {
            stack.push(node.val);
            current = &node.next;
        }

        let mut carry = 0;
        let mut new_stack = Vec::new();
        while let Some(val) = stack.pop() {
            let doubled = val * 2 + carry;
            new_stack.push(doubled % 10);
            carry = doubled / 10;
        }
        if carry > 0 {
            new_stack.push(carry);
        }

        let mut new_head = None;
        while let Some(val) = new_stack.pop() {
            let mut node = ListNode::new(val);
            node.next = new_head;
            new_head = Some(Box::new(node));
        }
        new_head
    }
}
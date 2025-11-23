impl Solution {
    pub fn reverse_k_group(head: Option<Box<ListNode>>, k: i32) -> Option<Box<ListNode>> {
        let mut head = head;
        let mut dummy = ListNode::new(0);
        let mut tail = &mut dummy;
        let mut stack = Vec::with_capacity(k as usize);

        while let Some(mut node) = head {
            head = node.next.take();
            stack.push(node);
            if stack.len() == k as usize {
                while let Some(node) = stack.pop() {
                    tail.next = Some(node);
                    tail = tail.next.as_mut().unwrap();
                }
            }
        }

        for node in stack.into_iter() {
            tail.next = Some(node);
            tail = tail.next.as_mut().unwrap();
        }

        dummy.next
    }
}
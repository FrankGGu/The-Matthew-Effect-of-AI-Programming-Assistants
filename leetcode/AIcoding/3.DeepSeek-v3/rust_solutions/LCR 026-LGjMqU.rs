impl Solution {
    pub fn reorder_list(head: &mut Option<Box<ListNode>>) {
        if head.is_none() {
            return;
        }

        let mut nodes = Vec::new();
        let mut curr = head.take();

        while let Some(mut node) = curr {
            let next = node.next.take();
            nodes.push(node);
            curr = next;
        }

        let mut dummy = Box::new(ListNode::new(0));
        let mut tail = &mut dummy;
        let mut left = 0;
        let mut right = nodes.len() - 1;

        while left <= right {
            tail.next = Some(nodes[left].clone());
            tail = tail.next.as_mut().unwrap();
            if left != right {
                tail.next = Some(nodes[right].clone());
                tail = tail.next.as_mut().unwrap();
            }
            left += 1;
            right -= 1;
        }

        *head = dummy.next;
    }
}
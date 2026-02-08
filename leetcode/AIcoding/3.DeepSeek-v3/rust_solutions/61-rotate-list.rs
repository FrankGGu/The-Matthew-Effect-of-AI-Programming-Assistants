impl Solution {
    pub fn rotate_right(head: Option<Box<ListNode>>, k: i32) -> Option<Box<ListNode>> {
        if head.is_none() || k == 0 {
            return head;
        }

        let mut len = 0;
        let mut current = &head;
        while let Some(node) = current {
            len += 1;
            current = &node.next;
        }

        let k = k % len;
        if k == 0 {
            return head;
        }

        let mut head = head;
        let mut fast = &mut head;
        for _ in 0..(len - k) {
            if let Some(node) = fast {
                fast = &mut node.next;
            }
        }

        let mut new_head = fast.take();
        let mut tail = &mut new_head;
        while let Some(node) = tail {
            tail = &mut node.next;
        }
        *tail = head;

        new_head
    }
}
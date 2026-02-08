impl Solution {
    pub fn split_list_to_parts(head: Option<Box<ListNode>>, k: i32) -> Vec<Option<Box<ListNode>>> {
        let mut len = 0;
        let mut current = &head;
        while let Some(node) = current {
            len += 1;
            current = &node.next;
        }

        let k = k as usize;
        let width = len / k;
        let remainder = len % k;

        let mut result = vec![None; k];
        let mut current = head;

        for i in 0..k {
            let mut part_len = width;
            if i < remainder {
                part_len += 1;
            }

            if part_len == 0 {
                result[i] = None;
                continue;
            }

            let mut dummy = Box::new(ListNode::new(0));
            let mut tail = &mut dummy;

            for _ in 0..part_len {
                if let Some(mut node) = current {
                    current = node.next.take();
                    tail.next = Some(node);
                    tail = tail.next.as_mut().unwrap();
                }
            }

            result[i] = dummy.next;
        }

        result
    }
}
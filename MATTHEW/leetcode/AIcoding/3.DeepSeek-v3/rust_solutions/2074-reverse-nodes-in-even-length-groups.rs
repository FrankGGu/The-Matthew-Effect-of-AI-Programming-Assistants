impl Solution {
    pub fn reverse_even_length_groups(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        let mut head = head;
        let mut dummy = Some(Box::new(ListNode { val: 0, next: head }));
        let mut prev = &mut dummy;
        let mut group_size = 1;

        while prev.as_ref()?.next.is_some() {
            let mut node = prev.as_mut()?.next.take();
            let mut count = 0;
            let mut tail = &mut node;
            while count < group_size && tail.is_some() {
                tail = &mut tail.as_mut()?.next;
                count += 1;
            }

            if count % 2 == 0 {
                let reversed = Self::reverse_list(node, count);
                prev.as_mut()?.next = reversed;
                for _ in 0..count {
                    prev = &mut prev.as_mut()?.next;
                }
            } else {
                prev.as_mut()?.next = node;
                for _ in 0..count {
                    prev = &mut prev.as_mut()?.next;
                }
            }

            group_size += 1;
        }

        dummy?.next
    }

    fn reverse_list(head: Option<Box<ListNode>>, count: usize) -> Option<Box<ListNode>> {
        let mut prev = None;
        let mut curr = head;
        for _ in 0..count {
            if let Some(mut node) = curr {
                let next = node.next.take();
                node.next = prev;
                prev = Some(node);
                curr = next;
            }
        }
        prev
    }
}
impl Solution {
    pub fn odd_even_list(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        if head.is_none() {
            return None;
        }

        let mut odd_head = None;
        let mut odd_tail = None;
        let mut even_head = None;
        let mut even_tail = None;

        let mut current = head;
        let mut is_odd = true;

        while let Some(mut node) = current {
            current = node.next.take();

            if is_odd {
                if odd_head.is_none() {
                    odd_head = Some(node);
                    odd_tail = odd_head.as_mut();
                } else if let Some(tail) = odd_tail.as_mut() {
                    tail.next = Some(node);
                    odd_tail = tail.next.as_mut();
                }
            } else {
                if even_head.is_none() {
                    even_head = Some(node);
                    even_tail = even_head.as_mut();
                } else if let Some(tail) = even_tail.as_mut() {
                    tail.next = Some(node);
                    even_tail = tail.next.as_mut();
                }
            }

            is_odd = !is_odd;
        }

        if let Some(tail) = odd_tail.as_mut() {
            tail.next = even_head;
        }

        odd_head
    }
}
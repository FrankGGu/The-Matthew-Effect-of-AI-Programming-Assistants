impl Solution {
    pub fn reorder_list(head: &mut Option<Box<ListNode>>) {
        if head.is_none() {
            return;
        }

        let mut len = 0;
        let mut node = head.as_ref();
        while let Some(n) = node {
            len += 1;
            node = n.next.as_ref();
        }

        let mut node = head.as_mut();
        for _ in 0..(len - 1) / 2 {
            node = node.unwrap().next.as_mut();
        }

        let mut second_half = node.unwrap().next.take();
        let mut prev = None;
        let mut curr = second_half;
        while let Some(mut node) = curr {
            let next = node.next.take();
            node.next = prev;
            prev = Some(node);
            curr = next;
        }
        second_half = prev;

        let mut first = head.as_mut();
        let mut second = second_half;
        while let Some(second_node) = second {
            let next_second = second_node.next.take();
            let first_node = first.unwrap();
            let next_first = first_node.next.take();
            first_node.next = Some(second_node);
            first_node.next.as_mut().unwrap().next = next_first;
            first = first_node.next.as_mut().unwrap().next.as_mut();
            second = next_second;
        }
    }
}
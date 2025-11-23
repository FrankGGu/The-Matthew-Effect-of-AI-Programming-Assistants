impl Solution {
    pub fn reverse_even_length_groups(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        let mut dummy = Some(Box::new(ListNode::new(0)));
        let mut current = dummy.as_mut();
        let mut count = 1;
        let mut group_start = head;

        while group_start.is_some() {
            let (mut group, mut group_size) = (None, 0);
            let mut temp = group_start.as_ref();

            while group_size < count && temp.is_some() {
                let next = temp.unwrap().next.take();
                let mut node = temp.unwrap().clone();
                node.next = group;
                group = Some(node);
                group_size += 1;
                temp = next.as_ref();
            }

            if group_size % 2 == 0 {
                let mut prev = None;
                let mut current_group = group;
                while let Some(mut node) = current_group {
                    let next = node.next.take();
                    node.next = prev;
                    prev = Some(node);
                    current_group = next;
                }
                group = prev;
            }

            current.as_mut().unwrap().next = group;
            while current.as_ref().unwrap().next.is_some() {
                current = &mut current.as_mut().unwrap().next;
            }

            group_start = temp.map(|node| node.next).unwrap_or(None);
            count += 1;
        }

        dummy.unwrap().next
    }
}
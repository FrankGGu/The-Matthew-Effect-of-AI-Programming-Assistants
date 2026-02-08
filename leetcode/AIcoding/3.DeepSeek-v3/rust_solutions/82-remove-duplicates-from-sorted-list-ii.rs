impl Solution {
    pub fn delete_duplicates(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        let mut dummy = Some(Box::new(ListNode { val: 0, next: head }));
        let mut current = &mut dummy;

        while current.as_ref()?.next.is_some() {
            let mut next_node = current.as_mut()?.next.take();
            let mut has_dup = false;

            while next_node.as_ref()?.next.is_some() && next_node.as_ref()?.val == next_node.as_ref()?.next.as_ref()?.val {
                has_dup = true;
                next_node = next_node.as_mut()?.next.take();
            }

            if has_dup {
                current.as_mut()?.next = next_node.as_mut()?.next.take();
            } else {
                current.as_mut()?.next = next_node.take();
                current = &mut current.as_mut()?.next;
            }
        }

        dummy?.next
    }
}
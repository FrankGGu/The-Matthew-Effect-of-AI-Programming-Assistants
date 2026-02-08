impl Solution {
    pub fn insertion_sort_list(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        let mut dummy = Some(Box::new(ListNode::new(0)));
        let mut current = head;

        while let Some(mut node) = current {
            current = node.next.take();
            let mut prev = &mut dummy;

            while prev.as_ref().unwrap().next.is_some() && prev.as_ref().unwrap().next.as_ref().unwrap().val < node.val {
                prev = &mut prev.as_mut().unwrap().next;
            }

            node.next = prev.as_mut().unwrap().next.take();
            prev.as_mut().unwrap().next = Some(node);
        }

        dummy.unwrap().next
    }
}
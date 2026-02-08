impl Solution {
    pub fn delete_duplicates(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        let mut current = head;
        let mut prev = None;
        let mut new_head = None;
        let mut tail = &mut new_head;

        while let Some(mut node) = current {
            current = node.next.take();
            if prev.is_none() || prev.unwrap() != node.val {
                prev = Some(node.val);
                *tail = Some(node);
                tail = &mut tail.as_mut().unwrap().next;
            }
        }
        new_head
    }
}
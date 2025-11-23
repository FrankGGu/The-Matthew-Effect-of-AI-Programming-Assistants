impl Solution {
    pub fn swap_pairs(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        let mut dummy = ListNode::new(0);
        dummy.next = head;
        let mut prev = &mut dummy;

        while let Some(mut first) = prev.next.take() {
            if let Some(mut second) = first.next.take() {
                first.next = second.next.take();
                second.next = Some(first);
                prev.next = Some(second);
                prev = prev.next.as_mut().unwrap().next.as_mut().unwrap();
            } else {
                prev.next = Some(first);
                break;
            }
        }

        dummy.next
    }
}
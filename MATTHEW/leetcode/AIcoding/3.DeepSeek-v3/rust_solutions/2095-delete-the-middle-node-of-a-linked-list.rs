impl Solution {
    pub fn delete_middle(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        if head.as_ref().unwrap().next.is_none() {
            return None;
        }

        let mut dummy = Some(Box::new(ListNode { val: 0, next: head }));
        let mut slow = dummy.as_mut();
        let mut fast = dummy.as_ref();

        while fast.is_some() && fast.as_ref().unwrap().next.is_some() {
            fast = fast.unwrap().next.as_ref().and_then(|n| n.next.as_ref());
            slow = slow.unwrap().next.as_mut();
        }

        let next = slow.as_mut().unwrap().next.as_mut().unwrap().next.take();
        slow.as_mut().unwrap().next = next;

        dummy.unwrap().next
    }
}
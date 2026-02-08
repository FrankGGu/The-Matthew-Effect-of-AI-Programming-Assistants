impl Solution {
    pub fn remove_nth_from_end(head: Option<Box<ListNode>>, n: i32) -> Option<Box<ListNode>> {
        let mut dummy = Some(Box::new(ListNode { val: 0, next: head }));
        let mut fast = dummy.as_ref();
        let mut slow = dummy.as_mut();

        for _ in 0..n {
            fast = fast.unwrap().next.as_ref();
        }

        while fast.as_ref().unwrap().next.is_some() {
            fast = fast.unwrap().next.as_ref();
            slow = slow.unwrap().next.as_mut();
        }

        let next = slow.as_mut().unwrap().next.as_mut().unwrap().next.take();
        slow.as_mut().unwrap().next = next;

        dummy.unwrap().next
    }
}
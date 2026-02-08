impl Solution {
    pub fn remove_nth_from_end(head: Option<Box<ListNode>>, n: i32) -> Option<Box<ListNode>> {
        let mut dummy = Some(Box::new(ListNode { val: 0, next: head }));
        let mut slow = dummy.as_mut();
        let mut fast = dummy.as_mut();

        for _ in 0..n {
            fast = fast.unwrap().next.as_mut();
        }

        while fast.is_some() && fast.unwrap().next.is_some() {
            slow = slow.unwrap().next.as_mut();
            fast = fast.unwrap().next.as_mut();
        }

        slow.unwrap().next = slow.unwrap().next.take().unwrap().next;

        dummy.unwrap().next
    }
}
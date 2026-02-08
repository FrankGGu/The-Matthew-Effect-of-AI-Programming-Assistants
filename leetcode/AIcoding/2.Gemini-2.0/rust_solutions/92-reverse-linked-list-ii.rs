impl Solution {
    pub fn reverse_between(head: Option<Box<ListNode>>, left: i32, right: i32) -> Option<Box<ListNode>> {
        let mut dummy = Some(Box::new(ListNode { val: 0, next: head }));
        let mut pre = &mut dummy;
        for _ in 1..left {
            pre = &mut pre.as_mut().unwrap().next;
        }

        let mut curr = pre.as_mut().unwrap().next.take();
        let mut next = None;
        for _ in left..=right {
            let mut temp = curr.as_mut().unwrap().next.take();
            curr.as_mut().unwrap().next = next;
            next = curr;
            curr = temp;
        }

        pre.as_mut().unwrap().next = next;
        let mut tail = pre.as_mut().unwrap().next.as_mut().unwrap();
        while tail.next.is_some() {
            tail = tail.next.as_mut().unwrap();
        }
        tail.next = curr;

        dummy.unwrap().next
    }
}
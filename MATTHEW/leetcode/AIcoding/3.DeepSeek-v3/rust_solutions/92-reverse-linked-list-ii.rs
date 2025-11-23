impl Solution {
    pub fn reverse_between(head: Option<Box<ListNode>>, left: i32, right: i32) -> Option<Box<ListNode>> {
        let mut dummy = Some(Box::new(ListNode { val: 0, next: head }));
        let mut prev = &mut dummy;
        for _ in 1..left {
            prev = &mut prev.as_mut()?.next;
        }
        let mut curr = prev.as_mut()?.next.take();
        let mut next = None;
        for _ in left..=right {
            let mut node = curr.take()?;
            curr = node.next.take();
            node.next = next;
            next = Some(node);
        }
        let tail = prev.as_mut()?.next.take();
        prev.as_mut()?.next = next;
        while prev.as_ref()?.next.is_some() {
            prev = &mut prev.as_mut()?.next;
        }
        prev.as_mut()?.next = curr;
        dummy?.next
    }
}
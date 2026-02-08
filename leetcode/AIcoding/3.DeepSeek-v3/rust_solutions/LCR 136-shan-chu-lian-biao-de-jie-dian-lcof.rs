impl Solution {
    pub fn delete_node(head: Option<Box<ListNode>>, val: i32) -> Option<Box<ListNode>> {
        let mut dummy = Some(Box::new(ListNode { val: 0, next: head }));
        let mut prev = &mut dummy;
        while let Some(node) = prev {
            if let Some(next) = &mut node.next {
                if next.val == val {
                    node.next = next.next.take();
                    break;
                }
            }
            prev = &mut prev.as_mut().unwrap().next;
        }
        dummy.unwrap().next
    }
}
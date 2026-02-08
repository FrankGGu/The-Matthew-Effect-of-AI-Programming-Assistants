impl Solution {
    pub fn remove_elements(head: Option<Box<ListNode>>, val: i32) -> Option<Box<ListNode>> {
        let mut dummy_head = Some(Box::new(ListNode { val: 0, next: head }));
        let mut current_ptr = &mut dummy_head.as_mut().unwrap().next;

        while let Some(node) = current_ptr {
            if node.val == val {
                *current_ptr = node.next.take();
            } else {
                current_ptr = &mut node.next;
            }
        }

        dummy_head.unwrap().next
    }
}
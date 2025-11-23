impl Solution {
    pub fn remove_elements(head: Option<Box<ListNode>>, val: i32) -> Option<Box<ListNode>> {
        let mut dummy = Box::new(ListNode { val: 0, next: head });
        let mut current = dummy.as_mut();

        while let Some(next_node) = current.next.take() {
            if next_node.val == val {
                current.next = next_node.next;
            } else {
                current.next = Some(next_node);
                current = current.next.as_mut().unwrap();
            }
        }

        dummy.next
    }
}
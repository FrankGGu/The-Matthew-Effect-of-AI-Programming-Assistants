impl Solution {
    pub fn remove_elements(head: Option<Box<ListNode>>, val: i32) -> Option<Box<ListNode>> {
        let mut dummy = Some(Box::new(ListNode { val: -1, next: head }));
        let mut current = &mut dummy;

        while let Some(node) = current {
            if let Some(next_node) = &node.next {
                if next_node.val == val {
                    node.next = next_node.next.clone();
                } else {
                    current = &mut node.next;
                }
            } else {
                break;
            }
        }

        dummy.unwrap().next
    }
}
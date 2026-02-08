impl Solution {
    pub fn delete_duplicates(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        let mut current = head;
        let mut ptr = &mut current;

        while let Some(node) = ptr.as_mut() {
            let mut next_node_ptr = &mut node.next;
            while let Some(next_node) = next_node_ptr.as_mut() {
                if node.val == next_node.val {
                    *next_node_ptr = next_node.next.take();
                } else {
                    break;
                }
            }
            ptr = &mut node.next;
        }

        current
    }
}
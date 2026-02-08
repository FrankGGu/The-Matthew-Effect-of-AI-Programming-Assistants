impl Solution {
    pub fn delete_node(node: &mut Option<Box<ListNode>>) {
        if let Some(n) = node {
            if let Some(next_node) = n.next.take() {
                n.val = next_node.val;
                n.next = next_node.next;
            }
        }
    }
}
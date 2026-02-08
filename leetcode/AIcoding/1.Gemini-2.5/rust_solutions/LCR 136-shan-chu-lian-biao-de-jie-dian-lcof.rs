impl Solution {
    pub fn delete_node(node: &mut ListNode) {
        let next_node = node.next.as_mut().unwrap();
        node.val = next_node.val;
        node.next = next_node.next.take();
    }
}
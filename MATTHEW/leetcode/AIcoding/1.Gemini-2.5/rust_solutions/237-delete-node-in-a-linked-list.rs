impl Solution {
    pub fn delete_node(node: &mut ListNode) {
        let next_node_box_ref = node.next.as_mut().unwrap();
        node.val = next_node_box_ref.val;
        node.next = next_node_box_ref.next.take();
    }
}
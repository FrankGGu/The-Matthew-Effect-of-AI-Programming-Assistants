impl Solution {
    pub fn delete_node(node: &mut Option<Box<ListNode>>) {
        if let Some(n) = node {
            if let Some(next) = n.next.take() {
                node.replace(next);
            } else {
                *node = None;
            }
        }
    }
}
impl Solution {
    pub fn get_intersection_node(head_a: Option<Box<ListNode>>, head_b: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        let mut current_a = &head_a;
        let mut current_b = &head_b;

        while current_a.as_ref().map(|n| &**n as *const ListNode) != current_b.as_ref().map(|n| &**n as *const ListNode) {
            current_a = if let Some(node) = current_a {
                &node.next
            } else {
                &head_b
            };

            current_b = if let Some(node) = current_b {
                &node.next
            } else {
                &head_a
            };
        }

        current_a.cloned()
    }
}
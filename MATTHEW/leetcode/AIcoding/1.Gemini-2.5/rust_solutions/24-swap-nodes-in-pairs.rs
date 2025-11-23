impl Solution {
    pub fn swap_pairs(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        if let Some(mut first_node) = head {
            if let Some(mut second_node) = first_node.next.take() {
                first_node.next = Self::swap_pairs(second_node.next.take());
                second_node.next = Some(first_node);
                Some(second_node)
            } else {
                Some(first_node)
            }
        } else {
            None
        }
    }
}
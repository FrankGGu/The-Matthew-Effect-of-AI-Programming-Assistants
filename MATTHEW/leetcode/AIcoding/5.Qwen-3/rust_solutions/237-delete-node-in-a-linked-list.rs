impl Solution {
    pub fn delete_node(mut node: Option<Box<ListNode>>) {
        if let Some(mut current) = node {
            if let Some(next) = current.next {
                current.val = next.val;
                current.next = next.next;
            }
        }
    }
}
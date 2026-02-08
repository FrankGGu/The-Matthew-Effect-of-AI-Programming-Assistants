use std::collections::HashSet;

impl Solution {
    pub fn has_cycle(head: Option<Box<ListNode>>) -> bool {
        let mut visited = HashSet::new();
        let mut current = head;
        while let Some(node) = current {
            if visited.contains(&node.as_ref() as *const ListNode) {
                return true;
            }
            visited.insert(node.as_ref() as *const ListNode);
            current = node.next;
        }
        false
    }
}
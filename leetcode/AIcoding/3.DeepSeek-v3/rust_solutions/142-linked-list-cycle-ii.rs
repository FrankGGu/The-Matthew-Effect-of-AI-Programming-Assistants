use std::collections::HashSet;

impl Solution {
    pub fn detect_cycle(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        let mut visited = HashSet::new();
        let mut current = head.as_ref();
        while let Some(node) = current {
            if visited.contains(&(node.as_ref() as *const ListNode)) {
                return Some(Box::new(ListNode {
                    val: node.val,
                    next: node.next.clone(),
                }));
            }
            visited.insert(node.as_ref() as *const ListNode);
            current = node.next.as_ref();
        }
        None
    }
}
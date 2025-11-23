impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn can_reach(head: Option<Box<ListNode>>, target: i32) -> bool {
        let mut visited = HashSet::new();
        let mut current = head;

        while let Some(node) = current {
            if node.val == target {
                return true;
            }
            if visited.contains(&node.val) {
                return false;
            }
            visited.insert(node.val);
            current = node.next;
        }

        false
    }
}

#[derive(PartialEq, Eq, Clone, Debug)]
pub struct ListNode {
    pub val: i32,
    pub next: Option<Box<ListNode>>,
}

pub struct Solution;
}
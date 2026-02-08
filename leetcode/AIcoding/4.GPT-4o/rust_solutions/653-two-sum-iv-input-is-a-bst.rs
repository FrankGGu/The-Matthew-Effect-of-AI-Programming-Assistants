use std::collections::HashSet;
use crate::TreeNode;

impl Solution {
    pub fn find_target(root: Option<Box<TreeNode>>, k: i32) -> bool {
        let mut set = HashSet::new();
        Self::traverse(&root, k, &mut set)
    }

    fn traverse(node: &Option<Box<TreeNode>>, k: i32, set: &mut HashSet<i32>) -> bool {
        if let Some(n) = node {
            if set.contains(&(k - n.val)) {
                return true;
            }
            set.insert(n.val);
            return Self::traverse(&n.left, k, set) || Self::traverse(&n.right, k, set);
        }
        false
    }
}
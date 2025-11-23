use std::collections::HashSet;
use crate::TreeNode;

pub fn find_target(root: Option<Box<TreeNode>>, k: i32) -> bool {
    fn dfs(node: Option<&Box<TreeNode>>, k: i32, seen: &mut HashSet<i32>) -> bool {
        if let Some(n) = node {
            if seen.contains(&(k - n.val)) {
                return true;
            }
            seen.insert(n.val);
            dfs(n.left.as_ref(), k, seen) || dfs(n.right.as_ref(), k, seen)
        } else {
            false
        }
    }

    dfs(root.as_ref(), k, &mut HashSet::new())
}
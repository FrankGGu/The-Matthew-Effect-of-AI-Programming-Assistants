use crate::TreeNode;

impl Solution {
    pub fn remove_leaves(root: Option<Box<TreeNode>>, target: i32) -> Option<Box<TreeNode>> {
        if let Some(mut node) = root {
            node.left = Self::remove_leaves(node.left, target);
            node.right = Self::remove_leaves(node.right, target);
            if node.left.is_none() && node.right.is_none() && node.val == target {
                return None;
            }
            Some(node)
        } else {
            None
        }
    }
}
#[derive(TreeNode)]
pub struct TreeNode {
    val: i32,
    left: Option<Box<TreeNode>>,
    right: Option<Box<TreeNode>>,
}

impl Solution {
    pub fn is_subtree(root: Option<Box<TreeNode>>, sub_root: Option<Box<TreeNode>>) -> bool {
        if sub_root.is_none() {
            return true;
        }
        if root.is_none() {
            return false;
        }
        if Self::is_same_tree(&root, &sub_root) {
            return true;
        }
        Self::is_subtree(root.as_ref().unwrap().left.clone(), sub_root.clone()) ||
        Self::is_subtree(root.as_ref().unwrap().right.clone(), sub_root.clone())
    }

    fn is_same_tree(p: &Option<Box<TreeNode>>, q: &Option<Box<TreeNode>>) -> bool {
        match (p, q) {
            (None, None) => true,
            (Some(node_p), Some(node_q)) => {
                node_p.val == node_q.val &&
                Self::is_same_tree(&node_p.left, &node_q.left) &&
                Self::is_same_tree(&node_p.right, &node_q.right)
            },
            _ => false,
        }
    }
}
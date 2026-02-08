#[derive(TreeNode)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

impl Solution {
    pub fn is_same_tree(p: Option<Box<TreeNode>>, q: Option<Box<TreeNode>>) -> bool {
        match (p, q) {
            (None, None) => true,
            (Some(node_p), Some(node_q)) => {
                node_p.val == node_q.val
                    && Self::is_same_tree(node_p.left, node_q.left)
                    && Self::is_same_tree(node_p.right, node_q.right)
            }
            _ => false,
        }
    }
}
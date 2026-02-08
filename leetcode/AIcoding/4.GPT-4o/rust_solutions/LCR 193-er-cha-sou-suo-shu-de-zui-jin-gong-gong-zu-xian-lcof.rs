#[derive(TreeNode)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

impl Solution {
    pub fn lowest_common_ancestor(
        root: Option<Box<TreeNode>>, 
        p: Option<Box<TreeNode>>, 
        q: Option<Box<TreeNode>>
    ) -> Option<Box<TreeNode>> {
        let (p_val, q_val) = (p.as_ref()?.val, q.as_ref()?.val);
        let mut current = root;

        while let Some(node) = current {
            if node.val < p_val && node.val < q_val {
                current = node.right;
            } else if node.val > p_val && node.val > q_val {
                current = node.left;
            } else {
                return Some(node);
            }
        }
        None
    }
}
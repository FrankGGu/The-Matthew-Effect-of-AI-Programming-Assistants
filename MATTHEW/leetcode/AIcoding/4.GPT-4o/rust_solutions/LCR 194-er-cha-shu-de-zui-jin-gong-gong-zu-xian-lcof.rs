#[derive(TreeNode)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

impl Solution {
    pub fn lowest_common_ancestor(root: Option<Box<TreeNode>>, p: Option<Box<TreeNode>>, q: Option<Box<TreeNode>>) -> Option<Box<TreeNode>> {
        let (p_val, q_val) = (p.as_ref()?.val, q.as_ref()?.val);
        Self::lca_helper(root, p_val, q_val)
    }

    fn lca_helper(root: Option<Box<TreeNode>>, p: i32, q: i32) -> Option<Box<TreeNode>> {
        if root.is_none() {
            return None;
        }
        let root_val = root.as_ref()?.val;
        if root_val == p || root_val == q {
            return root;
        }

        let left = Self::lca_helper(root.as_ref()?.left.clone(), p, q);
        let right = Self::lca_helper(root.as_ref()?.right.clone(), p, q);

        if left.is_some() && right.is_some() {
            return root;
        }
        left.or(right)
    }
}
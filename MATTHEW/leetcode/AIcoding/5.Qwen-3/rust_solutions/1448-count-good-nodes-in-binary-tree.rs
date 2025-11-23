impl Solution {

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

pub fn good_nodes(root: Option<Box<TreeNode>>) -> i32 {
    fn dfs(node: &Option<Box<TreeNode>>, max_val: i32) -> i32 {
        if let Some(n) = node {
            let current_max = std::cmp::max(max_val, n.val);
            let left = dfs(&n.left, current_max);
            let right = dfs(&n.right, current_max);
            1 + left + right
        } else {
            0
        }
    }

    dfs(&root, i32::MIN)
}
}
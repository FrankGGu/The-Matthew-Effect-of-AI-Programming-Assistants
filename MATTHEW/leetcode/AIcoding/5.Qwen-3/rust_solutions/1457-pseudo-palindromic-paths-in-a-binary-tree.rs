impl Solution {

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

pub fn pseudo_palindromic_paths (root: Option<Box<TreeNode>>) -> i32 {
    fn dfs(node: &Option<Box<TreeNode>>, path: i32) -> i32 {
        if let Some(n) = node {
            let path = path ^ (1 << n.val);
            if n.left.is_none() && n.right.is_none() {
                return if path.count_ones() <= 1 { 1 } else { 0 };
            }
            let left = dfs(&n.left, path);
            let right = dfs(&n.right, path);
            left + right
        } else {
            0
        }
    }
    dfs(&root, 0)
}
}
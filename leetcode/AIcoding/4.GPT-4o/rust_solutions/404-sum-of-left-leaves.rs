#[derive(TreeNode)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

impl Solution {
    pub fn sum_of_left_leaves(root: Option<Box<TreeNode>>) -> i32 {
        fn dfs(node: &Option<Box<TreeNode>>, is_left: bool) -> i32 {
            match node {
                Some(n) => {
                    if n.left.is_none() && n.right.is_none() && is_left {
                        n.val
                    } else {
                        dfs(&n.left, true) + dfs(&n.right, false)
                    }
                }
                None => 0,
            }
        }
        dfs(&root, false)
    }
}
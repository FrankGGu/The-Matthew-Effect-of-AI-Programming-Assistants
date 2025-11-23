impl Solution {

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

impl TreeNode {
    #[inline]
    pub fn new(val: i32) -> Self {
        TreeNode {
            val,
            left: None,
            right: None,
        }
    }
}

pub fn lca_deepest_leaves(root: Option<Box<TreeNode>>) -> Option<Box<TreeNode>> {
    fn dfs(node: &Option<Box<TreeNode>>, depth: i32) -> (i32, Option<Box<TreeNode>>) {
        if let Some(n) = node {
            let (left_depth, left_lca) = dfs(&n.left, depth + 1);
            let (right_depth, right_lca) = dfs(&n.right, depth + 1);

            if left_depth == right_depth {
                (left_depth, Some(Box::new(TreeNode {
                    val: n.val,
                    left: n.left.clone(),
                    right: n.right.clone(),
                })))
            } else if left_depth > right_depth {
                (left_depth, left_lca)
            } else {
                (right_depth, right_lca)
            }
        } else {
            (depth, None)
        }
    }

    dfs(&root, 0).1
}
}
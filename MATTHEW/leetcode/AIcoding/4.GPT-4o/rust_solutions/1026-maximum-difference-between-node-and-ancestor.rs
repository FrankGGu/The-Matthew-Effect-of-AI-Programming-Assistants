use std::cmp;

struct TreeNode {
    val: i32,
    left: Option<Box<TreeNode>>,
    right: Option<Box<TreeNode>>,
}

impl TreeNode {
    fn new(val: i32) -> Self {
        TreeNode {
            val,
            left: None,
            right: None,
        }
    }
}

pub fn max_ancestor_diff(root: Option<Box<TreeNode>>) -> i32 {
    fn dfs(node: &Option<Box<TreeNode>>, min_val: i32, max_val: i32) -> i32 {
        if let Some(n) = node {
            let current_val = n.val;
            let new_min = cmp::min(min_val, current_val);
            let new_max = cmp::max(max_val, current_val);
            let left_diff = dfs(&n.left, new_min, new_max);
            let right_diff = dfs(&n.right, new_min, new_max);
            cmp::max(left_diff, right_diff)
        } else {
            max_val - min_val
        }
    }

    dfs(&root, i32::MAX, i32::MIN)
}
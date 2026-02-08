use std::collections::HashMap;

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

pub fn max_sum(root: Option<Box<TreeNode>>) -> i32 {
    fn dfs(node: &Option<Box<TreeNode>>, level_sums: &mut HashMap<i32, i32>, level: i32) {
        if let Some(n) = node {
            *level_sums.entry(level).or_insert(0) += n.val;
            dfs(&n.left, level_sums, level + 1);
            dfs(&n.right, level_sums, level + 1);
        }
    }

    let mut level_sums = HashMap::new();
    dfs(&root, &mut level_sums, 0);
    *level_sums.values().max().unwrap_or(&0)
}
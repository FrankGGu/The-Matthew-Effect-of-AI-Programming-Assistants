use std::collections::HashMap;

pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

impl TreeNode {
    #[inline]
    fn new(val: i32) -> Self {
        TreeNode {
            val,
            left: None,
            right: None,
        }
    }
}

pub fn min_cost(root: Option<Box<TreeNode>>) -> i32 {
    fn dfs(node: &Option<Box<TreeNode>>, costs: &mut HashMap<i32, i32>, depth: i32) {
        if let Some(n) = node {
            *costs.entry(depth).or_insert(0) += n.val;
            dfs(&n.left, costs, depth + 1);
            dfs(&n.right, costs, depth + 1);
        }
    }

    let mut costs = HashMap::new();
    dfs(&root, &mut costs, 0);

    let total_nodes = costs.len();
    let total_cost: i32 = costs.values().sum();

    let mut min_cost = i32::MAX;
    for &cost in costs.values() {
        min_cost = min_cost.min(total_cost - cost);
    }

    min_cost
}
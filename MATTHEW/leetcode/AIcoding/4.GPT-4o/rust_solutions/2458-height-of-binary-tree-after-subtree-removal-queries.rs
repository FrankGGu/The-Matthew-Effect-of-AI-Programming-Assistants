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

struct Solution;

impl Solution {
    pub fn tree_queries(root: Option<Box<TreeNode>>, queries: Vec<i32>) -> Vec<i32> {
        let mut heights = HashMap::new();
        let mut max_height = 0;

        fn dfs(node: &Option<Box<TreeNode>>, heights: &mut HashMap<i32, i32>, depth: i32) -> i32 {
            if let Some(n) = node {
                let left_height = dfs(&n.left, heights, depth + 1);
                let right_height = dfs(&n.right, heights, depth + 1);
                let height = 1 + left_height.max(right_height);
                heights.insert(n.val, height);
                height
            } else {
                0
            }
        }

        let height = dfs(&root, &mut heights, 0);
        let mut result = Vec::new();

        for query in queries {
            let mut max = 0;
            for (&val, &h) in &heights {
                if val != query {
                    max = max.max(h);
                }
            }
            result.push(max);
        }

        result
    }
}
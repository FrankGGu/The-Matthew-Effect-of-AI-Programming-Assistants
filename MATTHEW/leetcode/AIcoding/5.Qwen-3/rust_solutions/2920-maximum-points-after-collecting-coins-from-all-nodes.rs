impl Solution {

use std::collections::{HashMap, VecDeque};

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<TreeNode>,
    pub right: Option<TreeNode>,
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

pub fn max_points(root: Option<Box<TreeNode>>) -> i32 {
    fn dfs(node: &Option<Box<TreeNode>>, depth: i32, map: &mut HashMap<i32, i32>) -> i32 {
        if let Some(n) = node {
            let current_depth = depth + 1;
            let points = *map.entry(current_depth).or_insert(0);
            let left = dfs(&n.left, current_depth, map);
            let right = dfs(&n.right, current_depth, map);
            *map.get_mut(&current_depth).unwrap() += n.val + left + right;
            return n.val + left + right;
        }
        0
    }

    let mut map = HashMap::new();
    dfs(&root, 0, &mut map);
    map.values().sum()
}
}
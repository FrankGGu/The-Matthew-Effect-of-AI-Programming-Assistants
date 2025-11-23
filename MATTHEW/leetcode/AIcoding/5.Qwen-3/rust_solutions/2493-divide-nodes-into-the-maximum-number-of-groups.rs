impl Solution {

use std::collections::{HashMap, VecDeque};

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>,
}

pub fn max_groups(root: Option<Box<TreeNode>>) -> i32 {
    let mut depth_map = HashMap::new();
    dfs(&root, 0, &mut depth_map);

    let mut freq = HashMap::new();
    for &depth in depth_map.values() {
        *freq.entry(depth).or_insert(0) += 1;
    }

    let mut max_groups = 0;
    for &count in freq.values() {
        max_groups += count;
    }

    max_groups
}

fn dfs(node: &Option<Box<TreeNode>>, depth: i32, depth_map: &mut HashMap<i32, i32>) {
    if let Some(n) = node {
        *depth_map.entry(depth).or_insert(0) += 1;
        dfs(&n.left, depth + 1, depth_map);
        dfs(&n.right, depth + 1, depth_map);
    }
}
}
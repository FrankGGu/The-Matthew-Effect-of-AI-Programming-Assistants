impl Solution {

use std::collections::{HashMap, VecDeque};

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

pub fn longest_path(root: Option<Box<TreeNode>>) -> i32 {
    fn dfs(node: &Option<Box<TreeNode>>, map: &mut HashMap<i32, i32>) -> i32 {
        if let Some(n) = node {
            let left = dfs(&n.left, map);
            let right = dfs(&n.right, map);

            let count = *map.entry(n.val).or_insert(0);
            map.insert(n.val, count + 1);

            let max_len = left + right + 1;
            return max_len;
        }
        0
    }

    let mut map = HashMap::new();
    dfs(&root, &mut map);
    let max = map.values().max().copied().unwrap_or(0);
    max
}
}
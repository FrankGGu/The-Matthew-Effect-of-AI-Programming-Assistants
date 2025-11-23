impl Solution {

use std::cmp;

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
struct Solution;

impl Solution {
    pub fn collect_coins(root: Option<Box<TreeNode>>) -> i32 {
        if root.is_none() {
            return 0;
        }

        let mut root = root.unwrap();
        let mut depth = 0;

        Self::dfs(&mut root, &mut depth);

        return depth;
    }

    fn dfs(node: &mut Box<TreeNode>, depth: &mut i32) -> i32 {
        let left = if let Some(left) = &mut node.left {
            Self::dfs(left, depth)
        } else {
            0
        };

        let right = if let Some(right) = &mut node.right {
            Self::dfs(right, depth)
        } else {
            0
        };

        if left == 0 && right == 0 {
            *depth += 1;
            return 1;
        }

        if left == 0 {
            node.right = None;
        } else if right == 0 {
            node.left = None;
        }

        return cmp::max(left, right) + 1;
    }
}

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
}
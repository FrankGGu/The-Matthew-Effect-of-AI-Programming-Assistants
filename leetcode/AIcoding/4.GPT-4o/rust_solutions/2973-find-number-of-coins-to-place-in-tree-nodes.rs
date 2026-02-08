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

pub struct Solution;

impl Solution {
    pub fn distribute_coins(root: Option<Box<TreeNode>>) -> i32 {
        fn dfs(node: &Option<Box<TreeNode>>, moves: &mut i32) -> i32 {
            if let Some(n) = node {
                let left = dfs(&n.left, moves);
                let right = dfs(&n.right, moves);
                *moves += (left.abs() + right.abs());
                n.val + left + right - 1
            } else {
                0
            }
        }

        let mut moves = 0;
        dfs(&root, &mut moves);
        moves
    }
}
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
    pub fn find_subtree_sizes(root: Option<Box<TreeNode>>) -> Vec<i32> {
        let mut sizes = Vec::new();
        Self::calculate_size(&root, &mut sizes);
        sizes
    }

    fn calculate_size(node: &Option<Box<TreeNode>>, sizes: &mut Vec<i32>) -> i32 {
        if let Some(n) = node {
            let left_size = Self::calculate_size(&n.left, sizes);
            let right_size = Self::calculate_size(&n.right, sizes);
            let size = 1 + left_size + right_size;
            sizes.push(size);
            size
        } else {
            0
        }
    }
}
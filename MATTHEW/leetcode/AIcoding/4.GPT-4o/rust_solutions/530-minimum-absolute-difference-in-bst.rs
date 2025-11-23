use std::cmp::Ordering;

#[derive(TreeNode)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

impl Solution {
    pub fn get_minimum_difference(root: Option<Box<TreeNode>>) -> i32 {
        let mut prev = None;
        let mut min_diff = i32::MAX;
        let mut stack = vec![];
        let mut current = root;

        while current.is_some() || !stack.is_empty() {
            while let Some(node) = current {
                stack.push(node);
                current = node.left;
            }

            if let Some(node) = stack.pop() {
                if let Some(p) = prev {
                    min_diff = min_diff.min((node.val - p).abs());
                }
                prev = Some(node.val);
                current = node.right;
            }
        }

        min_diff
    }
}
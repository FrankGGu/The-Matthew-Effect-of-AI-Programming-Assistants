impl Solution {

use std::collections::VecDeque;

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<TreeNode>,
    pub right: Option<TreeNode>,
}

pub fn average_of_levels(root: Option<Box<TreeNode>>) -> Vec<f64> {
    let mut result = Vec::new();
    let mut queue = VecDeque::new();

    if let Some(node) = root {
        queue.push_back(node);
    }

    while !queue.is_empty() {
        let level_size = queue.len();
        let mut sum = 0.0;

        for _ in 0..level_size {
            if let Some(node) = queue.pop_front() {
                sum += node.val as f64;

                if let Some(left) = node.left {
                    queue.push_back(left);
                }

                if let Some(right) = node.right {
                    queue.push_back(right);
                }
            }
        }

        result.push(sum / level_size as f64);
    }

    result
}
}
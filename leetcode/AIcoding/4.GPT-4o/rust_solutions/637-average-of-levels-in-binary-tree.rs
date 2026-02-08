use std::collections::VecDeque;

#[derive(TreeNode)]
struct TreeNode {
    val: i32,
    left: Option<Box<TreeNode>>,
    right: Option<Box<TreeNode>>,
}

impl Solution {
    pub fn average_of_levels(root: Option<Box<TreeNode>>) -> Vec<f64> {
        let mut result = Vec::new();
        let mut queue = VecDeque::new();
        if let Some(node) = root {
            queue.push_back(node);
        }

        while !queue.is_empty() {
            let level_size = queue.len();
            let mut level_sum = 0.0;

            for _ in 0..level_size {
                if let Some(node) = queue.pop_front() {
                    level_sum += node.val as f64;
                    if let Some(left) = node.left {
                        queue.push_back(left);
                    }
                    if let Some(right) = node.right {
                        queue.push_back(right);
                    }
                }
            }
            result.push(level_sum / level_size as f64);
        }
        result
    }
}
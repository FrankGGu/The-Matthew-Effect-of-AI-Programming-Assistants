use std::collections::VecDeque;

#[derive(TreeNode)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

pub fn level_order(root: Option<Box<TreeNode>>) -> Vec<Vec<i32>> {
    let mut result = Vec::new();
    let mut queue = VecDeque::new();

    if let Some(node) = root {
        queue.push_back(node);
    }

    while !queue.is_empty() {
        let level_size = queue.len();
        let mut current_level = Vec::new();

        for _ in 0..level_size {
            if let Some(node) = queue.pop_front() {
                current_level.push(node.val);
                if let Some(left) = node.left {
                    queue.push_back(left);
                }
                if let Some(right) = node.right {
                    queue.push_back(right);
                }
            }
        }

        result.push(current_level);
    }

    result
}
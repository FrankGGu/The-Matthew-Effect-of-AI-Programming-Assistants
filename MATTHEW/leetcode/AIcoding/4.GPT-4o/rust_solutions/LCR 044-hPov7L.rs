use std::collections::VecDeque;

#[derive(TreeNode)]
struct TreeNode {
    val: i32,
    left: Option<Box<TreeNode>>,
    right: Option<Box<TreeNode>>,
}

impl Solution {
    pub fn largest_values(root: Option<Box<TreeNode>>) -> Vec<i32> {
        let mut result = Vec::new();
        if root.is_none() {
            return result;
        }

        let mut queue = VecDeque::new();
        queue.push_back(root);

        while !queue.is_empty() {
            let level_size = queue.len();
            let mut max_value = i32::MIN;

            for _ in 0..level_size {
                if let Some(Some(node)) = queue.pop_front() {
                    max_value = max_value.max(node.val);
                    queue.push_back(node.left);
                    queue.push_back(node.right);
                }
            }
            result.push(max_value);
        }
        result
    }
}
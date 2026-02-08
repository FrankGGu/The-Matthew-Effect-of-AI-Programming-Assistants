use std::collections::VecDeque;

impl Solution {
    pub fn right_side_view(root: Option<Box<TreeNode>>) -> Vec<i32> {
        let mut result = Vec::new();
        if root.is_none() {
            return result;
        }

        let mut queue = VecDeque::new();
        queue.push_back(root);

        while !queue.is_empty() {
            let level_size = queue.len();
            for i in 0..level_size {
                if let Some(node) = queue.pop_front().unwrap() {
                    if i == level_size - 1 {
                        result.push(node.val);
                    }
                    if node.left.is_some() {
                        queue.push_back(node.left);
                    }
                    if node.right.is_some() {
                        queue.push_back(node.right);
                    }
                }
            }
        }
        result
    }
}
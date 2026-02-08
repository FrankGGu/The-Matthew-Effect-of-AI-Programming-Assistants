use std::collections::VecDeque;
use crate::TreeNode;

impl Solution {
    pub fn zigzag_level_order(root: Option<Box<TreeNode>>) -> Vec<Vec<i32>> {
        let mut result = Vec::new();
        if root.is_none() {
            return result;
        }

        let mut queue = VecDeque::new();
        queue.push_back(root);
        let mut left_to_right = true;

        while !queue.is_empty() {
            let mut level = Vec::new();
            let mut level_size = queue.len();

            while level_size > 0 {
                if let Some(Some(node)) = queue.pop_front() {
                    if left_to_right {
                        level.push(node.val);
                    } else {
                        level.insert(0, node.val);
                    }
                    if node.left.is_some() {
                        queue.push_back(node.left);
                    }
                    if node.right.is_some() {
                        queue.push_back(node.right);
                    }
                }
                level_size -= 1;
            }
            result.push(level);
            left_to_right = !left_to_right;
        }

        result
    }
}
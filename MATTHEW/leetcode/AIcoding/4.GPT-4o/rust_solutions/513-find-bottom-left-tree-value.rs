use std::collections::VecDeque;

#[derive(TreeNode)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

impl Solution {
    pub fn find_bottom_left_value(root: Option<Box<TreeNode>>) -> i32 {
        let mut queue = VecDeque::new();
        let mut bottom_left_value = 0;

        if let Some(node) = root {
            queue.push_back(node);
        }

        while !queue.is_empty() {
            let level_size = queue.len();
            bottom_left_value = queue.front().unwrap().val;

            for _ in 0..level_size {
                let current_node = queue.pop_front().unwrap();
                if let Some(left) = current_node.left {
                    queue.push_back(left);
                }
                if let Some(right) = current_node.right {
                    queue.push_back(right);
                }
            }
        }

        bottom_left_value
    }
}
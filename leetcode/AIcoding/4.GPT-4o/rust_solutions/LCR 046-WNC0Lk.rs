use std::collections::VecDeque;

#[derive(TreeNode)]
struct TreeNode {
    val: i32,
    left: Option<Box<TreeNode>>,
    right: Option<Box<TreeNode>>,
}

impl Solution {
    pub fn right_side_view(root: Option<Box<TreeNode>>) -> Vec<i32> {
        let mut result = Vec::new();
        let mut queue = VecDeque::new();
        if let Some(node) = root {
            queue.push_back(node);
        }

        while !queue.is_empty() {
            let size = queue.len();
            for i in 0..size {
                let node = queue.pop_front().unwrap();
                if i == size - 1 {
                    result.push(node.val);
                }
                if let Some(left) = node.left {
                    queue.push_back(left);
                }
                if let Some(right) = node.right {
                    queue.push_back(right);
                }
            }
        }
        result
    }
}
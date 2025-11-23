use std::collections::VecDeque;

#[derive(TreeNode)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

pub fn find_bottom_left_value(root: Option<Box<TreeNode>>) -> i32 {
    let mut queue = VecDeque::new();
    let mut result = 0;

    if let Some(node) = root {
        queue.push_back(node);
    }

    while !queue.is_empty() {
        let size = queue.len();
        for i in 0..size {
            if let Some(node) = queue.pop_front() {
                if i == 0 {
                    result = node.val;
                }
                if let Some(left) = node.left {
                    queue.push_back(left);
                }
                if let Some(right) = node.right {
                    queue.push_back(right);
                }
            }
        }
    }

    result
}
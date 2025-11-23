use std::collections::VecDeque;

pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

impl TreeNode {
    #[inline]
    fn new(val: i32) -> Self {
        TreeNode {
            val,
            left: None,
            right: None,
        }
    }
}

pub fn max_level_sum(root: Option<Box<TreeNode>>) -> i32 {
    let mut max_sum = i32::MIN;
    let mut result_level = 0;
    let mut queue = VecDeque::new();
    if let Some(node) = root {
        queue.push_back((node, 1));
    }

    while !queue.is_empty() {
        let level_size = queue.len();
        let mut current_sum = 0;
        for _ in 0..level_size {
            if let Some((node, level)) = queue.pop_front() {
                current_sum += node.val;
                if let Some(left) = node.left {
                    queue.push_back((left, level + 1));
                }
                if let Some(right) = node.right {
                    queue.push_back((right, level + 1));
                }
            }
        }
        if current_sum > max_sum {
            max_sum = current_sum;
            result_level = queue.len() + 1; // Current level
        }
    }

    result_level
}
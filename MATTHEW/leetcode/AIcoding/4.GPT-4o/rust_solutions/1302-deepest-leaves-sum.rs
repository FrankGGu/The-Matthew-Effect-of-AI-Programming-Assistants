use std::collections::VecDeque;

struct TreeNode {
    val: i32,
    left: Option<Box<TreeNode>>,
    right: Option<Box<TreeNode>>,
}

impl TreeNode {
    fn new(val: i32) -> Self {
        TreeNode {
            val,
            left: None,
            right: None,
        }
    }
}

struct Solution;

impl Solution {
    pub fn deepest_leaves_sum(root: Option<Box<TreeNode>>) -> i32 {
        let mut queue = VecDeque::new();
        if let Some(node) = root {
            queue.push_back(node);
        }
        let mut sum = 0;

        while !queue.is_empty() {
            sum = 0;
            let level_size = queue.len();
            for _ in 0..level_size {
                let node = queue.pop_front().unwrap();
                sum += node.val;
                if let Some(left) = node.left {
                    queue.push_back(left);
                }
                if let Some(right) = node.right {
                    queue.push_back(right);
                }
            }
        }
        sum
    }
}
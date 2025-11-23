impl Solution {

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

pub struct Solution {}

impl Solution {
    pub fn right_side_view(root: Option<Box<TreeNode>>) -> Vec<i32> {
        let mut result = Vec::new();
        let mut queue = std::collections::VecDeque::new();

        if let Some(node) = root {
            queue.push_back(node);
        }

        while !queue.is_empty() {
            let level_size = queue.len();

            for i in 0..level_size {
                if let Some(node) = queue.pop_front() {
                    if i == level_size - 1 {
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
        }

        result
    }
}
}
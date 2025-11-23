impl Solution {

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>,
}

impl TreeNode {
    #[inline]
    pub fn new(val: i32) -> Self {
        TreeNode {
            val,
            left: None,
            right: None,
        }
    }
}

pub struct Solution {}

impl Solution {
    pub fn decorate_tree(root: Option<Box<TreeNode>>) -> Vec<Vec<i32>> {
        let mut result = vec![];
        if root.is_none() {
            return result;
        }
        let mut queue = std::collections::VecDeque::new();
        queue.push_back(root.unwrap());
        while !queue.is_empty() {
            let level_size = queue.len();
            let mut level = vec![];
            for _ in 0..level_size {
                if let Some(node) = queue.pop_front() {
                    level.push(node.val);
                    if let Some(left) = node.left {
                        queue.push_back(left);
                    }
                    if let Some(right) = node.right {
                        queue.push_back(right);
                    }
                }
            }
            result.push(level);
        }
        result
    }
}
}
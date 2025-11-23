use std::collections::VecDeque;

#[derive(TreeNode)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

pub fn level_order_bottom(root: Option<Box<TreeNode>>) -> Vec<Vec<i32>> {
    let mut result = Vec::new();
    if root.is_none() {
        return result;
    }

    let mut queue = VecDeque::new();
    queue.push_back(root);

    while !queue.is_empty() {
        let mut level = Vec::new();
        let size = queue.len();

        for _ in 0..size {
            if let Some(Some(node)) = queue.pop_front() {
                level.push(node.val);
                queue.push_back(node.left);
                queue.push_back(node.right);
            }
        }

        result.push(level);
    }

    result.reverse();
    result
}
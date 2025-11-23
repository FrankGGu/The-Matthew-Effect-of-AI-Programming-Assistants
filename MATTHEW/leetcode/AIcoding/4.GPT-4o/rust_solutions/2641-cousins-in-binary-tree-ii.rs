use std::collections::VecDeque;

#[derive(TreeNode)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

pub fn cousins_in_binary_tree(root: Option<Box<TreeNode>>) -> Vec<Vec<i32>> {
    let mut result = Vec::new();
    if root.is_none() {
        return result;
    }

    let mut queue = VecDeque::new();
    queue.push_back(root);

    while !queue.is_empty() {
        let level_size = queue.len();
        let mut current_level = Vec::new();

        for _ in 0..level_size {
            if let Some(Some(node)) = queue.pop_front() {
                current_level.push(node.val);
                if node.left.is_some() {
                    queue.push_back(node.left);
                }
                if node.right.is_some() {
                    queue.push_back(node.right);
                }
            }
        }

        result.push(current_level);
    }

    result
}
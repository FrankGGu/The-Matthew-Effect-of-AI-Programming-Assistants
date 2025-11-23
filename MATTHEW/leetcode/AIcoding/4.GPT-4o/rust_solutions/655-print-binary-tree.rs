use std::collections::VecDeque;

#[derive(TreeNode)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

pub fn print_tree(root: Option<Box<TreeNode>>) -> Vec<Vec<String>> {
    let mut result = Vec::new();
    let mut queue = VecDeque::new();
    let mut height = 0;
    if let Some(node) = &root {
        queue.push_back((node.as_ref(), 1));
    }

    while !queue.is_empty() {
        let (node, level) = queue.pop_front().unwrap();
        if level > height {
            height = level;
        }
        let index = (2_usize.pow((height - level) as u32)) - 1;
        if result.len() < level as usize {
            result.push(vec!["".to_string(); (2_usize.pow(height as u32)) - 1]);
        }
        result[level as usize - 1][index] = node.val.to_string();
        if let Some(left) = &node.left {
            queue.push_back((left.as_ref(), level + 1));
        }
        if let Some(right) = &node.right {
            queue.push_back((right.as_ref(), level + 1));
        }
    }

    result
}
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

pub fn is_complete_tree(root: Option<Box<TreeNode>>) -> bool {
    let mut queue = VecDeque::new();
    let mut end = false;

    if let Some(node) = root {
        queue.push_back(node);
    }

    while let Some(node) = queue.pop_front() {
        if end && (node.left.is_some() || node.right.is_some()) {
            return false;
        }
        if node.left.is_none() {
            end = true;
        } else {
            queue.push_back(node.left.unwrap());
        }
        if node.right.is_none() {
            end = true;
        } else {
            queue.push_back(node.right.unwrap());
        }
    }

    true
}
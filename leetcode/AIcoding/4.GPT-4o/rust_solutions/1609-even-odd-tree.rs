use std::collections::VecDeque;

#[derive(TreeNode)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

pub fn is_even_odd_tree(root: Option<Box<TreeNode>>) -> bool {
    let mut queue = VecDeque::new();
    if let Some(node) = root {
        queue.push_back(node);
    }

    let mut level = 0;

    while !queue.is_empty() {
        let size = queue.len();
        let mut prev_val = if level % 2 == 0 { i32::MIN } else { i32::MAX };

        for _ in 0..size {
            let node = queue.pop_front().unwrap();
            let val = node.val;

            if level % 2 == 0 {
                if val % 2 == 0 || val <= prev_val {
                    return false;
                }
            } else {
                if val % 2 != 0 || val >= prev_val {
                    return false;
                }
            }
            prev_val = val;

            if let Some(left) = node.left {
                queue.push_back(left);
            }
            if let Some(right) = node.right {
                queue.push_back(right);
            }
        }
        level += 1;
    }

    true
}
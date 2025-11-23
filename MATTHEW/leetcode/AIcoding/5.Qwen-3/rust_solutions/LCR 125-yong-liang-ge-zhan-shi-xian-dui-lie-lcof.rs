impl Solution {

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
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

pub fn reverse_odd_levels(root: Option<Box<TreeNode>>) -> Option<Box<TreeNode>> {
    use std::collections::VecDeque;

    let mut queue = VecDeque::new();
    if let Some(node) = &root {
        queue.push_back(node);
    }

    let mut level = 0;
    while !queue.is_empty() {
        let size = queue.len();
        let mut level_nodes = Vec::new();

        for _ in 0..size {
            if let Some(node) = queue.pop_front() {
                level_nodes.push(node);
                if let Some(left) = &node.left {
                    queue.push_back(left);
                }
                if let Some(right) = &node.right {
                    queue.push_back(right);
                }
            }
        }

        if level % 2 == 1 {
            let len = level_nodes.len();
            for i in 0..len / 2 {
                let j = len - 1 - i;
                std::mem::swap(&mut level_nodes[i].val, &mut level_nodes[j].val);
            }
        }

        level += 1;
    }

    root
}
}
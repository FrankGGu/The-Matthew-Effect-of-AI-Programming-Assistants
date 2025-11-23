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

pub fn minimum_operations(root: Option<Box<TreeNode>>) -> i32 {
    let mut queue = VecDeque::new();
    let mut result = 0;

    if let Some(node) = root {
        queue.push_back(node);
    }

    while !queue.is_empty() {
        let mut level = Vec::new();
        let size = queue.len();

        for _ in 0..size {
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

        let mut sorted_level = level.clone();
        sorted_level.sort();
        let mut indices = (0..level.len()).collect::<Vec<_>>();
        indices.sort_by_key(|&i| level[i]);

        let mut visited = vec![false; level.len()];
        let mut cycles = 0;

        for i in 0..level.len() {
            if visited[i] || indices[i] == i {
                continue;
            }
            let mut j = i;
            while !visited[j] {
                visited[j] = true;
                j = indices[j];
            }
            cycles += 1;
        }

        result += level.len() - cycles;
    }

    result
}
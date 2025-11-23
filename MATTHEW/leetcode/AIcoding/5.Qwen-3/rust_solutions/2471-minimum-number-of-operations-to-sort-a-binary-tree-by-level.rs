impl Solution {

use std::collections::{HashMap, VecDeque};

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

pub fn minimum_operations(mut root: Option<Box<TreeNode>>) -> i32 {
    let mut levels = vec![];
    let mut queue = VecDeque::new();
    if let Some(node) = &root {
        queue.push_back(node);
    }

    while !queue.is_empty() {
        let level_size = queue.len();
        let mut level = vec![];
        for _ in 0..level_size {
            if let Some(node) = queue.pop_front() {
                level.push(node.val);
                if let Some(left) = &node.left {
                    queue.push_back(left);
                }
                if let Some(right) = &node.right {
                    queue.push_back(right);
                }
            }
        }
        levels.push(level);
    }

    let mut operations = 0;
    for level in levels {
        let mut sorted_level = level.clone();
        sorted_level.sort();
        let mut pos_map = HashMap::new();
        for (i, &val) in sorted_level.iter().enumerate() {
            pos_map.insert(val, i);
        }

        let mut visited = vec![false; level.len()];
        for i in 0..level.len() {
            if visited[i] {
                continue;
            }
            let mut cycle_size = 0;
            let mut j = i;
            while !visited[j] {
                visited[j] = true;
                let target = pos_map[&level[j]];
                j = target;
                cycle_size += 1;
            }
            if cycle_size > 0 {
                operations += cycle_size - 1;
            }
        }
    }

    operations
}
}
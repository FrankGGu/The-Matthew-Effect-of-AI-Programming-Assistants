impl Solution {

use std::collections::{HashMap, VecDeque};

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

pub fn width_of_binary_tree(root: Option<Box<TreeNode>>) -> i32 {
    if root.is_none() {
        return 0;
    }

    let mut queue = VecDeque::new();
    queue.push_back((root.unwrap(), 0));

    let mut max_width = 0;
    let mut level_map = HashMap::new();

    while let Some((node, index)) = queue.pop_front() {
        let level = level_map.entry(index / 2).or_insert(index);
        *level_map.get_mut(&index / 2).unwrap() = index;

        if let Some(left) = node.left {
            queue.push_back((left, index * 2));
        }
        if let Some(right) = node.right {
            queue.push_back((right, index * 2 + 1));
        }
    }

    for (_, &last_index) in level_map.iter() {
        max_width = max_width.max(last_index);
    }

    max_width as i32
}
}
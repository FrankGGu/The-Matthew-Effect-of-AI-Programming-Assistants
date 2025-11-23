impl Solution {

use std::collections::{HashSet, VecDeque};

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

pub fn validate_binary_tree_nodes(
    nodes: i32,
    left_child: Vec<i32>,
    right_child: Vec<i32>,
) -> bool {
    let mut parent = HashSet::new();
    let mut queue = VecDeque::new();

    for i in 0..nodes as usize {
        if left_child[i] != -1 {
            if !parent.insert(left_child[i]) {
                return false;
            }
            queue.push_back(left_child[i]);
        }
        if right_child[i] != -1 {
            if !parent.insert(right_child[i]) {
                return false;
            }
            queue.push_back(right_child[i]);
        }
    }

    let mut visited = HashSet::new();
    while let Some(node) = queue.pop_front() {
        if !visited.insert(node) {
            return false;
        }
        for &child in &[left_child[node as usize], right_child[node as usize]] {
            if child != -1 {
                queue.push_back(child);
            }
        }
    }

    visited.len() == nodes as usize
}
}
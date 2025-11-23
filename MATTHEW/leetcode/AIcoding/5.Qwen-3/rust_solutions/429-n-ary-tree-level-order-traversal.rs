impl Solution {

use std::collections::VecDeque;

#[derive(Debug, PartialEq, Eq)]
pub struct Node {
    pub val: i32,
    pub children: Vec<Node>,
}

impl Node {
    #[inline]
    pub fn new(val: i32) -> Self {
        Node { val, children: vec![] }
    }
}

pub fn level_order(root: Option<Box<Node>>) -> Vec<Vec<i32>> {
    let mut result = Vec::new();
    if root.is_none() {
        return result;
    }

    let mut queue = VecDeque::new();
    queue.push_back(root.unwrap());

    while !queue.is_empty() {
        let level_size = queue.len();
        let mut level_nodes = Vec::new();

        for _ in 0..level_size {
            if let Some(node) = queue.pop_front() {
                level_nodes.push(node.val);
                for child in node.children {
                    queue.push_back(Some(child));
                }
            }
        }

        if !level_nodes.is_empty() {
            result.push(level_nodes);
        }
    }

    result
}
}
impl Solution {

use std::collections::{HashMap, VecDeque};

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct Node {
    pub val: i32,
    pub neighbors: Vec<Node>,
}

impl Node {
    pub fn new(val: i32) -> Self {
        Node { val, neighbors: vec![] }
    }
}

pub fn clone_graph(node: Option<Box<Node>>) -> Option<Box<Node>> {
    if node.is_none() {
        return None;
    }

    let mut visited = HashMap::new();
    let queue = VecDeque::new();

    let original = node.unwrap();
    let cloned = Box::new(Node::new(original.val));
    visited.insert(original.val, cloned.clone());

    queue.push_back((original, cloned.clone()));

    while let Some((original_node, cloned_node)) = queue.pop_front() {
        for neighbor in original_node.neighbors {
            if let Some(cloned_neighbor) = visited.get(&neighbor.val) {
                cloned_node.neighbors.push(cloned_neighbor.clone());
            } else {
                let new_cloned = Box::new(Node::new(neighbor.val));
                visited.insert(neighbor.val, new_cloned.clone());
                cloned_node.neighbors.push(new_cloned.clone());
                queue.push_back((neighbor, new_cloned));
            }
        }
    }

    Some(cloned)
}
}
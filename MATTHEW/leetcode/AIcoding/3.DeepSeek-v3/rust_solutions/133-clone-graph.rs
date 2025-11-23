use std::collections::HashMap;
use std::collections::VecDeque;

#[derive(Debug, PartialEq, Eq)]
pub struct Node {
    pub val: i32,
    pub neighbors: Vec<Node>,
}

impl Node {
    #[inline]
    pub fn new(val: i32) -> Self {
        Node {
            val,
            neighbors: Vec::new(),
        }
    }
}

pub fn clone_graph(node: Option<Node>) -> Option<Node> {
    if node.is_none() {
        return None;
    }
    let mut visited = HashMap::new();
    let mut queue = VecDeque::new();
    queue.push_back(node.unwrap());
    visited.insert(1, Node::new(1));

    while let Some(current) = queue.pop_front() {
        let current_clone = visited.get(&current.val).unwrap();

        for neighbor in current.neighbors {
            if !visited.contains_key(&neighbor.val) {
                visited.insert(neighbor.val, Node::new(neighbor.val));
                queue.push_back(neighbor);
            }
            let neighbor_clone = visited.get(&neighbor.val).unwrap();
            current_clone.neighbors.push(neighbor_clone.clone());
        }
    }

    Some(visited.get(&1).unwrap().clone())
}
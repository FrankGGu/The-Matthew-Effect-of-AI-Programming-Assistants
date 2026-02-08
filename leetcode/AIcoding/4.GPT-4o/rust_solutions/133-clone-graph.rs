use std::collections::HashMap;

#[derive(Clone, PartialEq, Eq)]
pub struct Node {
    pub val: i32,
    pub neighbors: Vec<Node>,
}

impl Node {
    #[inline]
    fn new(val: i32) -> Self {
        Node {
            val,
            neighbors: Vec::new(),
        }
    }
}

pub fn clone_graph(node: Option<Box<Node>>) -> Option<Box<Node>> {
    let mut visited: HashMap<i32, Option<Box<Node>>> = HashMap::new();
    fn dfs(node: &Option<Box<Node>>, visited: &mut HashMap<i32, Option<Box<Node>>>) -> Option<Box<Node>> {
        if let Some(n) = node {
            if visited.contains_key(&n.val) {
                return visited[&n.val].clone();
            }
            let clone_node = Some(Box::new(Node::new(n.val)));
            visited.insert(n.val, clone_node.clone());
            for neighbor in &n.neighbors {
                if let Some(cloned_neighbor) = dfs(&Some(neighbor.clone()), visited) {
                    visited.get_mut(&n.val).unwrap().as_mut().unwrap().neighbors.push(cloned_neighbor);
                }
            }
            return clone_node;
        }
        None
    }
    dfs(&node, &mut visited)
}
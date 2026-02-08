use std::collections::{HashSet, HashMap};

pub fn count_visited_nodes(edges: Vec<Vec<i32>>, start: i32) -> i32 {
    let mut graph: HashMap<i32, Vec<i32>> = HashMap::new();
    for edge in edges {
        graph.entry(edge[0]).or_insert(Vec::new()).push(edge[1]);
    }

    let mut visited = HashSet::new();
    let mut stack = vec![start];

    while let Some(node) = stack.pop() {
        if visited.insert(node) {
            if let Some(neighbors) = graph.get(&node) {
                for &neighbor in neighbors {
                    stack.push(neighbor);
                }
            }
        }
    }

    visited.len() as i32
}
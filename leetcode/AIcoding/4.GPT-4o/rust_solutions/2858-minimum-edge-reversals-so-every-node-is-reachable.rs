use std::collections::{HashMap, HashSet, VecDeque};

pub fn min_edge_reversals(edges: Vec<Vec<i32>>) -> i32 {
    let mut graph: HashMap<i32, Vec<i32>> = HashMap::new();
    for edge in &edges {
        graph.entry(edge[0]).or_default().push(edge[1]);
        graph.entry(edge[1]).or_default().push(-edge[0]);
    }

    let mut queue = VecDeque::new();
    let mut visited = HashSet::new();
    let mut count = 0;

    queue.push_back(0);
    visited.insert(0);

    while let Some(node) = queue.pop_front() {
        for &neighbor in &graph[&node] {
            if !visited.contains(&neighbor.abs()) {
                visited.insert(neighbor.abs());
                queue.push_back(neighbor.abs());
                if neighbor > 0 {
                    count += 1;
                }
            }
        }
    }

    if visited.len() == graph.len() {
        count
    } else {
        -1
    }
}
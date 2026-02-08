use std::collections::{HashSet, HashMap, VecDeque};

pub fn reachable_nodes(edges: Vec<Vec<i32>>, max_moves: i32, n: i32) -> i32 {
    let mut graph: HashMap<i32, Vec<(i32, i32)>> = HashMap::new();
    for edge in edges {
        graph.entry(edge[0]).or_insert(vec![]).push((edge[1], edge[2]));
        graph.entry(edge[1]).or_insert(vec![]).push((edge[0], edge[2]));
    }

    let mut visited = HashSet::new();
    let mut queue = VecDeque::new();
    queue.push_back((0, max_moves));
    visited.insert(0);

    while let Some((node, moves_left)) = queue.pop_front() {
        for &(neighbor, weight) in graph.get(&node).unwrap_or(&vec![]) {
            if !visited.contains(&neighbor) {
                if moves_left >= weight {
                    visited.insert(neighbor);
                    queue.push_back((neighbor, moves_left - weight));
                }
            }
        }
    }

    let mut reachable = visited.len() as i32;
    for &(u, v, w) in &edges {
        let u_reachable = if visited.contains(&u) { 1 } else { 0 };
        let v_reachable = if visited.contains(&v) { 1 } else { 0 };
        reachable += std::cmp::min(w, (max_moves - 1) - (1 - u_reachable) - (1 - v_reachable));
    }

    reachable
}
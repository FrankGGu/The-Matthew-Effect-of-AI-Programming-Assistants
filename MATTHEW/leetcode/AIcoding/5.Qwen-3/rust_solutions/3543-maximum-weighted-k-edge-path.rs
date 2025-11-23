impl Solution {

use std::collections::{BinaryHeap, HashMap};

#[derive(Debug, PartialEq, Eq, Clone, Copy, Hash)]
struct Edge {
    to: i32,
    weight: i32,
}

impl Solution {
    pub fn max_weight_k_edge_path(n: i32, edges: Vec<Vec<i32>>, k: i32) -> i32 {
        let mut graph = HashMap::new();
        for edge in edges {
            let from = edge[0];
            let to = edge[1];
            let weight = edge[2];
            graph.entry(from).or_insert_with(Vec::new).push(Edge { to, weight });
        }

        let mut pq = BinaryHeap::new();
        for (&node, neighbors) in &graph {
            for &neighbor in neighbors {
                pq.push((neighbor.weight, 1, node, neighbor.to));
            }
        }

        let mut visited = HashMap::new();
        while let Some((weight, steps, u, v)) = pq.pop() {
            if steps == k {
                return weight;
            }
            if visited.contains_key(&(u, v, steps)) {
                continue;
            }
            visited.insert((u, v, steps), true);
            if let Some(neighbors) = graph.get(&v) {
                for &next in neighbors {
                    pq.push((weight + next.weight, steps + 1, v, next.to));
                }
            }
        }

        -1
    }
}
}
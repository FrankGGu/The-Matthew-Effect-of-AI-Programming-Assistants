use std::collections::BinaryHeap;
use std::cmp::Ordering;

#[derive(Copy, Clone, Eq, PartialEq)]
struct State {
    cost: i32,
    position: usize,
}

impl Ord for State {
    fn cmp(&self, other: &Self) -> Ordering {
        other.cost.cmp(&self.cost)
    }
}

impl PartialOrd for State {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        Some(self.cmp(other))
    }
}

impl Solution {
    pub fn shortest_path_in_weighted_tree(n: i32, edges: Vec<Vec<i32>>, start_node: i32) -> Vec<i32> {
        let num_nodes = n as usize;
        let start_node_idx = start_node as usize;

        let mut adj: Vec<Vec<(usize, i32)>> = vec![vec![]; num_nodes];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            let w = edge[2];
            adj[u].push((v, w));
            adj[v].push((u, w));
        }

        let mut dist: Vec<i32> = vec![i32::MAX; num_nodes];
        dist[start_node_idx] = 0;

        let mut pq = BinaryHeap::new();
        pq.push(State { cost: 0, position: start_node_idx });

        while let Some(State { cost, position }) = pq.pop() {
            if cost > dist[position] {
                continue;
            }

            for &(neighbor, weight) in &adj[position] {
                let new_cost = cost + weight;

                if new_cost < dist[neighbor] {
                    dist[neighbor] = new_cost;
                    pq.push(State { cost: new_cost, position: neighbor });
                }
            }
        }

        dist
    }
}
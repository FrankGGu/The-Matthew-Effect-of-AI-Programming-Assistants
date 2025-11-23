use std::collections::BinaryHeap;
use std::cmp::Ordering;

const INF: i64 = std::i64::MAX;

#[derive(Copy, Clone, Eq, PartialEq)]
struct State {
    cost: i64,
    node: usize,
}

impl Ord for State {
    fn cmp(&self, other: &Self) -> Ordering {
        // Min-heap based on cost
        other.cost.cmp(&self.cost)
    }
}

impl PartialOrd for State {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        Some(self.cmp(other))
    }
}

fn dijkstra(n: usize, adj: &Vec<Vec<(usize, i32)>>, start: usize) -> Vec<i64> {
    let mut dist: Vec<i64> = vec![INF; n];
    let mut heap = BinaryHeap::new();

    dist[start] = 0;
    heap.push(State { cost: 0, node: start });

    while let Some(State { cost, node }) = heap.pop() {
        if cost > dist[node] {
            continue;
        }

        for &(neighbor, weight) in &adj[node] {
            let new_cost = cost + weight as i64;
            if new_cost < dist[neighbor] {
                dist[neighbor] = new_cost;
                heap.push(State { cost: new_cost, node: neighbor });
            }
        }
    }
    dist
}

impl Solution {
    pub fn minimum_weighted_subgraph(n: i32, edges: Vec<Vec<i32>>, source1: i32, source2: i32, dest: i32) -> i64 {
        let n_usize = n as usize;
        let s1 = source1 as usize;
        let s2 = source2 as usize;
        let d = dest as usize;

        let mut adj: Vec<Vec<(usize, i32)>> = vec![vec![]; n_usize];
        let mut rev_adj: Vec<Vec<(usize, i32)>> = vec![vec![]; n_usize];

        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            let w = edge[2];
            adj[u].push((v, w));
            rev_adj[v].push((u, w)); 
        }

        let dist_s1 = dijkstra(n_usize, &adj, s1);
        let dist_s2 = dijkstra(n_usize, &adj, s2);
        let dist_d_rev = dijkstra(n_usize, &rev_adj, d); 

        let mut min_total_weight = INF;

        for m in 0..n_usize {
            if dist_s1[m] != INF && dist_s2[m] != INF && dist_d_rev[m] != INF {
                let current_total_weight = dist_s1[m] + dist_s2[m] + dist_d_rev[m];
                min_total_weight = min_total_weight.min(current_total_weight);
            }
        }

        if min_total_weight == INF {
            -1
        } else {
            min_total_weight
        }
    }
}
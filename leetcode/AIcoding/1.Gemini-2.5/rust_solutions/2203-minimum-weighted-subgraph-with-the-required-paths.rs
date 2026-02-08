use std::collections::BinaryHeap;
use std::cmp::Ordering;

#[derive(Eq, PartialEq, Copy, Clone)]
struct State {
    cost: i64,
    position: usize,
}

impl Ord for State {
    fn cmp(&self, other: &Self) -> Ordering {
        other.cost.cmp(&self.cost)
            .then_with(|| self.position.cmp(&other.position))
    }
}

impl PartialOrd for State {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        Some(self.cmp(other))
    }
}

const INF: i64 = std::i64::MAX / 2;

fn dijkstra(n: usize, adj: &[Vec<(usize, i64)>], start: usize) -> Vec<i64> {
    let mut dist = vec![INF; n];
    let mut pq = BinaryHeap::new();

    dist[start] = 0;
    pq.push(State { cost: 0, position: start });

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

impl Solution {
    pub fn minimum_weighted_subgraph(n: i32, edges: Vec<Vec<i32>>, source1: i32, source2: i32, dest: i32) -> i64 {
        let n = n as usize;
        let source1 = source1 as usize;
        let source2 = source2 as usize;
        let dest = dest as usize;

        let mut adj: Vec<Vec<(usize, i64)>> = vec![vec![]; n];
        let mut rev_adj: Vec<Vec<(usize, i64)>> = vec![vec![]; n];

        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            let w = edge[2] as i64;
            adj[u].push((v, w));
            rev_adj[v].push((u, w));
        }

        let dist1 = dijkstra(n, &adj, source1);
        let dist2 = dijkstra(n, &adj, source2);
        let dist_rev_dest = dijkstra(n, &rev_adj, dest);

        let mut min_total_weight = INF;

        for i in 0..n {
            if dist1[i] != INF && dist2[i] != INF && dist_rev_dest[i] != INF {
                let current_total_weight = dist1[i] + dist2[i] + dist_rev_dest[i];
                if current_total_weight < min_total_weight {
                    min_total_weight = current_total_weight;
                }
            }
        }

        if min_total_weight == INF {
            -1
        } else {
            min_total_weight
        }
    }
}
use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn min_cost_to_reach_every_position(start_pos: Vec<i32>, end_pos: Vec<i32>, cost: Vec<i32>) -> i64 {
        let n = cost.len() + 1;
        let mut adj: Vec<Vec<(usize, i64)>> = vec![vec![]; n];

        for i in 0..cost.len() {
            adj[i].push((i + 1, cost[i] as i64));
            adj[i + 1].push((i, cost[i] as i64));
        }

        let start_node = n - 1;
        let end_node = n - 2;

        let mut dist: Vec<i64> = vec![i64::MAX; n];
        dist[start_node] = 0;

        let mut pq: BinaryHeap<Reverse<(i64, usize)>> = BinaryHeap::new();
        pq.push(Reverse((0, start_node)));

        while let Some(Reverse((d, u))) = pq.pop() {
            if d > dist[u] {
                continue;
            }

            for &(v, weight) in &adj[u] {
                if dist[u] + weight < dist[v] {
                    dist[v] = dist[u] + weight;
                    pq.push(Reverse((dist[v], v)));
                }
            }
        }

        dist[end_node]
    }
}
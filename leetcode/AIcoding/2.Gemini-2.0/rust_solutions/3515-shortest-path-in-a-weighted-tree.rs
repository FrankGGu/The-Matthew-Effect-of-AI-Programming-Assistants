use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn shortest_path(n: i32, edges: Vec<Vec<i32>>, succ_prob: Vec<f64>, start: i32, end: i32) -> f64 {
        let n = n as usize;
        let mut adj: Vec<Vec<(usize, f64)>> = vec![Vec::new(); n];
        for i in 0..edges.len() {
            let u = edges[i][0] as usize;
            let v = edges[i][1] as usize;
            adj[u].push((v, succ_prob[i]));
            adj[v].push((u, succ_prob[i]));
        }

        let mut dist: Vec<f64> = vec![0.0; n];
        dist[start as usize] = 1.0;

        let mut pq: BinaryHeap<(Reverse<f64>, usize)> = BinaryHeap::new();
        pq.push((Reverse(1.0), start as usize));

        while let Some((Reverse(d), u)) = pq.pop() {
            if d < dist[u] {
                continue;
            }

            for &(v, prob) in &adj[u] {
                if dist[u] * prob > dist[v] {
                    dist[v] = dist[u] * prob;
                    pq.push((Reverse(dist[v]), v));
                }
            }
        }

        dist[end as usize]
    }
}
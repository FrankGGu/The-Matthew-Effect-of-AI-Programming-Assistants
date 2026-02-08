use std::collections::BinaryHeap;

impl Solution {
    pub fn max_probability(n: i32, edges: Vec<Vec<i32>>, succ_prob: Vec<f64>, start: i32, end: i32) -> f64 {
        let n = n as usize;
        let start = start as usize;
        let end = end as usize;

        let mut adj: Vec<Vec<(usize, f64)>> = vec![vec![]; n];
        for i in 0..edges.len() {
            let u = edges[i][0] as usize;
            let v = edges[i][1] as usize;
            let p = succ_prob[i];
            adj[u].push((v, p));
            adj[v].push((u, p));
        }

        let mut max_prob: Vec<f64> = vec![0.0; n];
        max_prob[start] = 1.0;

        let mut pq: BinaryHeap<(f64, usize)> = BinaryHeap::new();
        pq.push((1.0, start));

        while let Some((current_prob, u)) = pq.pop() {
            if current_prob < max_prob[u] {
                continue;
            }

            if u == end {
                // Optimization: If we've popped the end node, and its probability
                // is current_prob, it means we've found the maximum probability
                // to reach 'end'. We can return early.
                // This is valid because BinaryHeap is a max-heap, and Dijkstra's
                // guarantees that the first time a node is popped, it's with its
                // maximum (or minimum for shortest path) value.
                return current_prob;
            }

            for &(v, edge_prob) in &adj[u] {
                let new_prob = current_prob * edge_prob;
                if new_prob > max_prob[v] {
                    max_prob[v] = new_prob;
                    pq.push((new_prob, v));
                }
            }
        }

        max_prob[end]
    }
}
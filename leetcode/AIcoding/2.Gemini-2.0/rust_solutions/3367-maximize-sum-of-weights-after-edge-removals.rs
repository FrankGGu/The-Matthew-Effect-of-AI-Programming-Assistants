use std::collections::BinaryHeap;

impl Solution {
    pub fn max_sum_edges(n: i32, edges: Vec<Vec<i32>>, k: i32) -> i64 {
        let mut adj: Vec<Vec<(usize, i32)>> = vec![vec![]; n as usize];
        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            let w = edge[2];
            adj[u].push((v, w));
            adj[v].push((u, w));
        }

        let mut weights: BinaryHeap<i32> = BinaryHeap::new();
        for edge in &edges {
            weights.push(edge[2]);
        }

        let mut sum: i64 = 0;
        for _ in 0..k {
            sum += weights.pop().unwrap() as i64;
        }

        sum
    }
}
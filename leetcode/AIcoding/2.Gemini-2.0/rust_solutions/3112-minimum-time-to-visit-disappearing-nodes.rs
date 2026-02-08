use std::collections::BinaryHeap;

impl Solution {
    pub fn minimum_time(n: i32, edges: Vec<Vec<i32>>, node_values: Vec<i32>) -> i64 {
        let n = n as usize;
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n];
        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u - 1].push(v - 1);
            adj[v - 1].push(u - 1);
        }

        let mut dist: Vec<i64> = vec![i64::MAX; n];
        dist[0] = 0;

        let mut pq: BinaryHeap<(i64, usize)> = BinaryHeap::new();
        pq.push((0, 0));

        let mut visited: Vec<bool> = vec![false; n];

        while let Some((d, u)) = pq.pop() {
            let d = -d;
            if visited[u] {
                continue;
            }
            visited[u] = true;

            for &v in &adj[u] {
                let cost = (node_values[v] as i64).max(1);
                if dist[v] > dist[u] + cost {
                    dist[v] = dist[u] + cost;
                    pq.push((-dist[v], v));
                }
            }
        }

        dist[n - 1]
    }
}
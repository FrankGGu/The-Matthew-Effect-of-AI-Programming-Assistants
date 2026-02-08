use std::collections::BinaryHeap;

impl Solution {
    pub fn count_paths(n: i32, roads: Vec<Vec<i32>>) -> i32 {
        let n = n as usize;
        let mut adj: Vec<Vec<(usize, i64)>> = vec![vec![]; n];
        for road in &roads {
            let u = road[0] as usize;
            let v = road[1] as usize;
            let w = road[2] as i64;
            adj[u].push((v, w));
            adj[v].push((u, w));
        }

        let mut dist: Vec<i64> = vec![i64::MAX; n];
        let mut ways: Vec<i64> = vec![0; n];
        dist[0] = 0;
        ways[0] = 1;

        let mut pq: BinaryHeap<(i64, usize)> = BinaryHeap::new();
        pq.push((0, 0));

        while let Some((d, u)) = pq.pop() {
            let d = -d;
            if d > dist[u] {
                continue;
            }

            for &(v, w) in &adj[u] {
                if dist[u] + w < dist[v] {
                    dist[v] = dist[u] + w;
                    ways[v] = ways[u];
                    pq.push((-dist[v], v));
                } else if dist[u] + w == dist[v] {
                    ways[v] = (ways[v] + ways[u]) % 1_000_000_007;
                }
            }
        }

        ways[n - 1] as i32
    }
}
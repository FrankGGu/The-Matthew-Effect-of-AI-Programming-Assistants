use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn count_paths(n: i32, roads: Vec<Vec<i32>>) -> i32 {
        let n = n as usize;
        let mut adj: Vec<Vec<(usize, i64)>> = vec![vec![]; n];
        for road in roads {
            let u = road[0] as usize;
            let v = road[1] as usize;
            let time = road[2] as i64;
            adj[u].push((v, time));
            adj[v].push((u, time));
        }

        let mut dist: Vec<i64> = vec![i64::MAX; n];
        let mut ways: Vec<i64> = vec![0; n];
        let mut pq: BinaryHeap<Reverse<(i64, usize)>> = BinaryHeap::new();

        let modulo = 1_000_000_007;

        dist[0] = 0;
        ways[0] = 1;
        pq.push(Reverse((0, 0)));

        while let Some(Reverse((d, u))) = pq.pop() {
            if d > dist[u] {
                continue;
            }

            for &(v, time) in &adj[u] {
                let new_dist = d + time;
                if new_dist < dist[v] {
                    dist[v] = new_dist;
                    ways[v] = ways[u];
                    pq.push(Reverse((new_dist, v)));
                } else if new_dist == dist[v] {
                    ways[v] = (ways[v] + ways[u]) % modulo;
                }
            }
        }

        ways[n - 1] as i32
    }
}
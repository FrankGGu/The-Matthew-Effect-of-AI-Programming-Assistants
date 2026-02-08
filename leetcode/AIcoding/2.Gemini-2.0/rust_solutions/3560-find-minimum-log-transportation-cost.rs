use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn min_cost(n: i32, logs: Vec<Vec<i32>>, cost: Vec<i32>) -> i32 {
        let n = n as usize;
        let mut adj: Vec<Vec<(usize, i32)>> = vec![vec![]; n + 1];
        for i in 0..logs.len() {
            adj[logs[i][0] as usize].push((logs[i][1] as usize, cost[i]));
            adj[logs[i][1] as usize].push((logs[i][0] as usize, cost[i]));
        }

        let mut dist: Vec<i32> = vec![i32::MAX; n + 1];
        dist[1] = 0;

        let mut pq: BinaryHeap<Reverse<(i32, usize)>> = BinaryHeap::new();
        pq.push(Reverse((0, 1)));

        while let Some(Reverse((d, u))) = pq.pop() {
            if d > dist[u] {
                continue;
            }

            for &(v, weight) in &adj[u] {
                if dist[v] > dist[u] + weight {
                    dist[v] = dist[u] + weight;
                    pq.push(Reverse((dist[v], v)));
                }
            }
        }

        if dist[n] == i32::MAX {
            return -1;
        }

        dist[n]
    }
}
use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn network_delay_time(times: Vec<Vec<i32>>, n: i32, k: i32) -> i32 {
        let n_usize = n as usize;
        let k_usize = k as usize;

        let mut adj: Vec<Vec<(usize, i32)>> = vec![vec![]; n_usize + 1];
        for time in times {
            let u = time[0] as usize;
            let v = time[1] as usize;
            let w = time[2];
            adj[u].push((v, w));
        }

        let mut dist: Vec<i32> = vec![i32::MAX; n_usize + 1];
        let mut pq: BinaryHeap<Reverse<(i32, usize)>> = BinaryHeap::new();

        dist[k_usize] = 0;
        pq.push(Reverse((0, k_usize)));

        while let Some(Reverse((d, u))) = pq.pop() {
            if d > dist[u] {
                continue;
            }

            for &(v, weight) in &adj[u] {
                if dist[u] != i32::MAX && dist[u] + weight < dist[v] {
                    dist[v] = dist[u] + weight;
                    pq.push(Reverse((dist[v], v)));
                }
            }
        }

        let mut max_time = 0;
        for i in 1..=n_usize {
            if dist[i] == i32::MAX {
                return -1;
            }
            if dist[i] > max_time {
                max_time = dist[i];
            }
        }

        max_time
    }
}
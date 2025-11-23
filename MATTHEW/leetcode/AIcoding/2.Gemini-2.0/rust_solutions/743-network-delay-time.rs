use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn network_delay_time(times: Vec<Vec<i32>>, n: i32, k: i32) -> i32 {
        let mut graph = vec![vec![]; n as usize + 1];
        for time in &times {
            graph[time[0] as usize].push((time[1] as usize, time[2]));
        }

        let mut dist = vec![i32::MAX; n as usize + 1];
        dist[k as usize] = 0;

        let mut pq = BinaryHeap::new();
        pq.push((Reverse(0), k as usize));

        while let Some((Reverse(d), u)) = pq.pop() {
            if d > dist[u] {
                continue;
            }

            for &(v, weight) in &graph[u] {
                if dist[v] > dist[u] + weight {
                    dist[v] = dist[u] + weight;
                    pq.push((Reverse(dist[v]), v));
                }
            }
        }

        let mut max_dist = 0;
        for i in 1..=n as usize {
            if dist[i] == i32::MAX {
                return -1;
            }
            max_dist = max_dist.max(dist[i]);
        }

        max_dist
    }
}
impl Solution {

use std::collections::{BinaryHeap, HashMap};

impl Solution {
    pub fn min_time_to_reach(&self, n: i32, k: i32, room_types: Vec<i32>, time: Vec<i32>) -> i32 {
        let n = n as usize;
        let k = k as usize;
        let mut graph = vec![vec![]; n];
        for i in 0..n {
            if i + 1 < n {
                graph[i].push(i + 1);
            }
            if i > 0 {
                graph[i].push(i - 1);
            }
        }

        let mut dist = vec![i32::MAX; n];
        let mut pq = BinaryHeap::new();
        dist[0] = 0;
        pq.push((0, 0));

        while let Some((d, u)) = pq.pop() {
            if d > dist[u] {
                continue;
            }

            for &v in &graph[u] {
                let new_dist = d + time[room_types[v] as usize];
                if new_dist < dist[v] {
                    dist[v] = new_dist;
                    pq.push((new_dist, v));
                }
            }
        }

        dist[n - 1]
    }
}

struct Solution;
}
use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn minimum_time(n: i32, edges: Vec<Vec<i32>>, disappear: Vec<i32>) -> Vec<i32> {
        let n = n as usize;
        let mut adj: Vec<Vec<(usize, i32)>> = vec![vec![]; n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            let w = edge[2];
            adj[u].push((v, w));
            adj[v].push((u, w));
        }

        let mut dist: Vec<i32> = vec![-1; n];
        let mut pq: BinaryHeap<Reverse<(i32, usize)>> = BinaryHeap::new();

        dist[0] = 0;
        pq.push(Reverse((0, 0))); // (time, node_id)

        while let Some(Reverse((d, u))) = pq.pop() {
            // If we've already found a shorter path to u, skip this stale entry.
            if dist[u] != -1 && d > dist[u] {
                continue;
            }

            // If the current time to reach 'u' is greater than or equal to its disappear time,
            // then 'u' has disappeared. We cannot use 'u' to traverse to its neighbors.
            if d >= disappear[u] {
                continue;
            }

            for &(v, weight) in &adj[u] {
                let new_time = d + weight;

                // If v has not been visited yet (dist[v] == -1) OR
                // if we found a shorter path to v
                if dist[v] == -1 || new_time < dist[v] {
                    dist[v] = new_time;
                    pq.push(Reverse((new_time, v)));
                }
            }
        }

        dist
    }
}
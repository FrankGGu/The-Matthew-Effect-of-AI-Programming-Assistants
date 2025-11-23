use std::collections::BinaryHeap;

impl Solution {
    pub fn min_cost(max_time: i32, edges: Vec<Vec<i32>>, passing_fees: Vec<i32>) -> i32 {
        let n = passing_fees.len();
        let mut adj = vec![vec![]; n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            let t = edge[2];
            adj[u].push((v, t));
            adj[v].push((u, t));
        }

        let mut cost = vec![std::i32::MAX; n];
        let mut time = vec![std::i32::MAX; n];
        cost[0] = passing_fees[0];
        time[0] = 0;

        let mut heap = BinaryHeap::new();
        heap.push((-cost[0], 0, 0));

        while let Some((current_cost, current_time, u)) = heap.pop() {
            let current_cost = -current_cost;
            if u == n - 1 {
                return current_cost;
            }
            if current_time > max_time {
                continue;
            }
            if current_cost > cost[u] || current_time > time[u] {
                continue;
            }
            for &(v, t) in &adj[u] {
                let new_time = current_time + t;
                let new_cost = current_cost + passing_fees[v];
                if new_time <= max_time && (new_cost < cost[v] || new_time < time[v]) {
                    if new_cost < cost[v] || new_time < time[v] {
                        cost[v] = cost[v].min(new_cost);
                        time[v] = time[v].min(new_time);
                        heap.push((-new_cost, new_time, v));
                    }
                }
            }
        }

        if cost[n - 1] != std::i32::MAX {
            cost[n - 1]
        } else {
            -1
        }
    }
}
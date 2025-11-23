use std::collections::BinaryHeap;
use std::cmp::Reverse;

const INF: i32 = std::i32::MAX;

impl Solution {
    pub fn min_cost(n: i32, edges: Vec<Vec<i32>>, max_time: i32) -> i32 {
        let n_usize = n as usize;
        let max_time_usize = max_time as usize;

        let mut adj: Vec<Vec<(usize, i32, i32)>> = vec![vec![]; n_usize];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            let time = edge[2];
            let cost = edge[3];
            adj[u].push((v, time, cost));
            adj[v].push((u, time, cost));
        }

        let mut min_cost_to_reach: Vec<Vec<i32>> = vec![vec![INF; max_time_usize + 1]; n_usize];

        let mut pq: BinaryHeap<Reverse<(i32, usize, usize)>> = BinaryHeap::new();

        min_cost_to_reach[0][0] = 0;
        pq.push(Reverse((0, 0, 0))); // (cost, time, city)

        while let Some(Reverse((current_cost, current_time, u))) = pq.pop() {
            if current_cost > min_cost_to_reach[u][current_time] {
                continue;
            }

            for &(v, travel_time, travel_cost) in &adj[u] {
                let new_time = current_time + travel_time as usize;
                let new_cost = current_cost + travel_cost;

                if new_time <= max_time_usize {
                    if new_cost < min_cost_to_reach[v][new_time] {
                        min_cost_to_reach[v][new_time] = new_cost;
                        pq.push(Reverse((new_cost, new_time, v)));
                    }
                }
            }
        }

        let mut min_total_cost = INF;
        for t in 0..=max_time_usize {
            min_total_cost = min_total_cost.min(min_cost_to_reach[n_usize - 1][t]);
        }

        if min_total_cost == INF {
            -1
        } else {
            min_total_cost
        }
    }
}
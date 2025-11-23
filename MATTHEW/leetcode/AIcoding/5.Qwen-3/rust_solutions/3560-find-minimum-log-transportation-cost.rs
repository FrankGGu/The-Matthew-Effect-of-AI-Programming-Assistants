impl Solution {

use std::cmp::Ordering;
use std::collections::BinaryHeap;

struct Solution;

impl Solution {
    pub fn min_transportation_cost(n: i32, roads: Vec<Vec<i32>>, k: i32) -> i32 {
        let n = n as usize;
        let k = k as usize;
        let mut graph = vec![vec![]; n];

        for road in roads {
            let u = road[0] as usize;
            let v = road[1] as usize;
            let cost = road[2];
            graph[u].push((v, cost));
            graph[v].push((u, cost));
        }

        let mut dist = vec![i32::MAX; n];
        dist[0] = 0;
        let mut heap = BinaryHeap::new();
        heap.push((0, 0));

        while let Some((current_dist, u)) = heap.pop() {
            if u == n - 1 {
                return current_dist;
            }
            if current_dist > dist[u] {
                continue;
            }
            for &(v, cost) in &graph[u] {
                let new_dist = current_dist + cost;
                if new_dist < dist[v] {
                    dist[v] = new_dist;
                    heap.push((new_dist, v));
                }
            }
        }

        -1
    }
}
}
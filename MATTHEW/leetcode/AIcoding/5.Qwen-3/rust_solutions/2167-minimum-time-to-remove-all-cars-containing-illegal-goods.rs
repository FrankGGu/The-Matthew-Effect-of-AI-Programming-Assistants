impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn minimum_time(roads: Vec<Vec<i32>>, cars: Vec<i32>) -> i32 {
        let n = roads.len();
        let mut dist = vec![i32::MAX; n];
        dist[0] = 0;
        let mut heap = std::collections::BinaryHeap::new();
        heap.push((0, 0));

        while let Some((d, u)) = heap.pop() {
            if d > dist[u] {
                continue;
            }
            for v in 0..n {
                if u != v {
                    let cost = roads[u][v];
                    if dist[v] > dist[u] + cost {
                        dist[v] = dist[u] + cost;
                        heap.push((dist[v], v));
                    }
                }
            }
        }

        let mut res = 0;
        for &car in &cars {
            res += dist[car as usize];
        }
        res
    }
}
}
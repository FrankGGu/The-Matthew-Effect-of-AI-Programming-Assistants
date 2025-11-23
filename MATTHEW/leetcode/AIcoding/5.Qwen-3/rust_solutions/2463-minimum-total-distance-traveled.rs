impl Solution {

use std::cmp::Ordering;
use std::collections::BinaryHeap;

impl Solution {
    pub fn total_distance(travelers: Vec<Vec<i32>>, paths: Vec<Vec<i32>>) -> i32 {
        let mut graph = vec![vec![]; 1000];
        for path in paths {
            let u = path[0] as usize;
            let v = path[1] as usize;
            let cost = path[2];
            graph[u].push((v, cost));
            graph[v].push((u, cost));
        }

        let mut dist = vec![i32::MAX; 1000];
        let mut heap = BinaryHeap::new();
        for &start in &travelers {
            let start = start as usize;
            dist.fill(i32::MAX);
            dist[start] = 0;
            heap.push((0, start));
            while let Some((d, u)) = heap.pop() {
                if d > dist[u] {
                    continue;
                }
                for &(v, w) in &graph[u] {
                    if dist[v] > dist[u] + w {
                        dist[v] = dist[u] + w;
                        heap.push((dist[v], v));
                    }
                }
            }
        }

        let mut result = 0;
        for &start in &travelers {
            let start = start as usize;
            result += dist[start];
        }

        result
    }
}
}
impl Solution {

use std::collections::{BinaryHeap, HashMap};

struct Solution;

impl Solution {
    pub fn min_cost(n: i32, edges: Vec<Vec<i32>>, start: i32, end: i32, k: i32) -> i32 {
        let mut graph = HashMap::new();
        for edge in edges {
            let u = edge[0];
            let v = edge[1];
            let w = edge[2];
            graph.entry(u).or_insert_with(Vec::new).push((v, w));
            graph.entry(v).or_insert_with(Vec::new).push((u, w));
        }

        let mut dist = vec![i32::MAX; n as usize];
        dist[start as usize] = 0;
        let mut heap = BinaryHeap::new();
        heap.push((0, start));

        while let Some((cost, node)) = heap.pop() {
            if node == end {
                return cost;
            }
            if cost > dist[node as usize] {
                continue;
            }
            for &(neighbor, weight) in graph.get(&node).into_iter().flatten() {
                let new_cost = cost + weight;
                if new_cost < dist[neighbor as usize] {
                    dist[neighbor as usize] = new_cost;
                    heap.push((new_cost, neighbor));
                }
            }
        }

        -1
    }
}
}
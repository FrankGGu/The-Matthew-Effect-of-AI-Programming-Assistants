use std::collections::HashMap;
use std::cmp::Reverse;
use std::collections::BinaryHeap;

struct Solution;

impl Solution {
    pub fn count_paths(n: i32, roads: Vec<Vec<i32>>) -> i32 {
        let mut graph: HashMap<i32, Vec<(i32, i32)>> = HashMap::new();
        for road in roads {
            graph.entry(road[0]).or_insert(Vec::new()).push((road[1], road[2]));
            graph.entry(road[1]).or_insert(Vec::new()).push((road[0], road[2]));
        }

        let mut dist = vec![i64::MAX; n as usize];
        let mut ways = vec![0; n as usize];
        let mut heap = BinaryHeap::new();

        dist[0] = 0;
        ways[0] = 1;
        heap.push(Reverse((0, 0))); // (distance, node)

        while let Some(Reverse((d, u))) = heap.pop() {
            if d > dist[u as usize] {
                continue;
            }
            for &(v, w) in &graph[&u] {
                let new_dist = d + w as i64;
                if new_dist < dist[v as usize] {
                    dist[v as usize] = new_dist;
                    ways[v as usize] = ways[u as usize];
                    heap.push(Reverse((new_dist, v)));
                } else if new_dist == dist[v as usize] {
                    ways[v as usize] += ways[u as usize];
                }
            }
        }

        (ways[(n - 1) as usize] % 1_000_000_007) as i32
    }
}
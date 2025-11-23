use std::collections::{BinaryHeap, HashMap};

pub struct Solution;

impl Solution {
    pub fn network_delay_time(times: Vec<Vec<i32>>, n: i32, k: i32) -> i32 {
        let mut graph: HashMap<i32, Vec<(i32, i32)>> = HashMap::new();
        for time in times {
            graph.entry(time[0]).or_insert(vec![]).push((time[1], time[2]));
        }

        let mut dist = vec![i32::MAX; (n + 1) as usize];
        dist[k as usize] = 0;

        let mut heap = BinaryHeap::new();
        heap.push((0, k));

        while let Some((d, node)) = heap.pop() {
            let d = -d;
            if d > dist[node as usize] {
                continue;
            }
            if let Some(neighbors) = graph.get(&node) {
                for &(neighbor, time) in neighbors {
                    let new_dist = d + time;
                    if new_dist < dist[neighbor as usize] {
                        dist[neighbor as usize] = new_dist;
                        heap.push((-new_dist, neighbor));
                    }
                }
            }
        }

        let max_time = dist[1..].iter().cloned().max().unwrap_or(i32::MAX);
        if max_time == i32::MAX { -1 } else { max_time }
    }
}
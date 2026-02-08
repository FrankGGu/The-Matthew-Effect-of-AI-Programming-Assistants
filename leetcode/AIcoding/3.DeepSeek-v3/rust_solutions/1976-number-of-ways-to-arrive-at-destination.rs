use std::collections::{BinaryHeap, HashMap};
use std::cmp::Ordering;

#[derive(Eq, PartialEq)]
struct State {
    node: usize,
    time: i64,
}

impl Ord for State {
    fn cmp(&self, other: &Self) -> Ordering {
        other.time.cmp(&self.time)
    }
}

impl PartialOrd for State {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        Some(self.cmp(other))
    }
}

impl Solution {
    pub fn count_paths(n: i32, roads: Vec<Vec<i32>>) -> i32 {
        let n = n as usize;
        let mut graph: Vec<Vec<(usize, i64)>> = vec![vec![]; n];
        for road in roads {
            let u = road[0] as usize;
            let v = road[1] as usize;
            let time = road[2] as i64;
            graph[u].push((v, time));
            graph[v].push((u, time));
        }

        let mut dist: Vec<i64> = vec![i64::MAX; n];
        let mut ways: Vec<i64> = vec![0; n];
        let mut heap = BinaryHeap::new();

        dist[0] = 0;
        ways[0] = 1;
        heap.push(State { node: 0, time: 0 });

        while let Some(State { node, time }) = heap.pop() {
            if time > dist[node] {
                continue;
            }

            for &(neighbor, cost) in &graph[node] {
                let new_time = time + cost;
                if new_time < dist[neighbor] {
                    dist[neighbor] = new_time;
                    ways[neighbor] = ways[node];
                    heap.push(State { node: neighbor, time: new_time });
                } else if new_time == dist[neighbor] {
                    ways[neighbor] = (ways[neighbor] + ways[node]) % 1_000_000_007;
                }
            }
        }

        ways[n - 1] as i32
    }
}
use std::collections::BinaryHeap;
use std::cmp::Ordering;

#[derive(Copy, Clone, Eq, PartialEq)]
struct State {
    time: i32,
    node: i32,
}

impl Ord for State {
    fn cmp(&self, other: &Self) -> Ordering {
        other.time.cmp(&self.time)
            .then_with(|| self.node.cmp(&other.node))
    }
}

impl PartialOrd for State {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        Some(self.cmp(other))
    }
}

struct Solution;

impl Solution {
    pub fn second_minimum(n: i32, edges: Vec<Vec<i32>>, time: i32, change: i32) -> i32 {
        let n_usize = n as usize;
        let mut adj: Vec<Vec<i32>> = vec![vec![]; n_usize + 1];

        for edge in edges {
            let u = edge[0];
            let v = edge[1];
            adj[u as usize].push(v);
            adj[v as usize].push(u);
        }

        let mut dist: Vec<Vec<i32>> = vec![vec![i32::MAX, i32::MAX]; n_usize + 1];
        let mut heap = BinaryHeap::new();

        dist[1][0] = 0;
        heap.push(State { time: 0, node: 1 });

        while let Some(State { time: current_time, node: u }) = heap.pop() {
            if current_time > dist[u as usize][1] {
                continue;
            }

            let num_cycles = current_time / change;
            let actual_departure_time = if num_cycles % 2 == 1 {
                (num_cycles + 1) * change
            } else {
                current_time
            };

            let time_to_neighbor = actual_departure_time + time;

            for &v in &adj[u as usize] {
                if time_to_neighbor < dist[v as usize][0] {
                    dist[v as usize][1] = dist[v as usize][0];
                    dist[v as usize][0] = time_to_neighbor;
                    heap.push(State { time: time_to_neighbor, node: v });
                } else if time_to_neighbor > dist[v as usize][0] && time_to_neighbor < dist[v as usize][1] {
                    dist[v as usize][1] = time_to_neighbor;
                    heap.push(State { time: time_to_neighbor, node: v });
                }
            }
        }

        dist[n as usize][1]
    }
}
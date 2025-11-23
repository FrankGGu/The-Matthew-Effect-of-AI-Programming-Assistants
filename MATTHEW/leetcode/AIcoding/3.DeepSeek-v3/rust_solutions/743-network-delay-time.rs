use std::collections::{BinaryHeap, HashMap};
use std::cmp::Ordering;

#[derive(Eq, PartialEq)]
struct State {
    node: i32,
    cost: i32,
}

impl Ord for State {
    fn cmp(&self, other: &Self) -> Ordering {
        other.cost.cmp(&self.cost)
    }
}

impl PartialOrd for State {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        Some(self.cmp(other))
    }
}

impl Solution {
    pub fn network_delay_time(times: Vec<Vec<i32>>, n: i32, k: i32) -> i32 {
        let mut graph: HashMap<i32, Vec<(i32, i32)>> = HashMap::new();
        for time in times {
            graph.entry(time[0]).or_default().push((time[1], time[2]));
        }

        let mut dist: Vec<i32> = vec![i32::MAX; (n + 1) as usize];
        dist[k as usize] = 0;
        let mut heap = BinaryHeap::new();
        heap.push(State { node: k, cost: 0 });

        while let Some(State { node, cost }) = heap.pop() {
            if cost > dist[node as usize] {
                continue;
            }
            if let Some(edges) = graph.get(&node) {
                for &(next_node, next_cost) in edges {
                    let new_cost = cost + next_cost;
                    if new_cost < dist[next_node as usize] {
                        dist[next_node as usize] = new_cost;
                        heap.push(State { node: next_node, cost: new_cost });
                    }
                }
            }
        }

        let max_time = *dist[1..=n as usize].iter().max().unwrap();
        if max_time == i32::MAX {
            -1
        } else {
            max_time
        }
    }
}
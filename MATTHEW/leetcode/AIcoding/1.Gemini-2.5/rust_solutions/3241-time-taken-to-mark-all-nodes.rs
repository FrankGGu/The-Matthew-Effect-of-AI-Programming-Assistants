use std::collections::{BinaryHeap, HashMap};
use std::cmp::Ordering;

#[derive(Copy, Clone, Eq, PartialEq)]
struct State {
    cost: i32,
    position: i32,
}

impl Ord for State {
    fn cmp(&self, other: &Self) -> Ordering {
        other.cost.cmp(&self.cost)
            .then_with(|| self.position.cmp(&other.position))
    }
}

impl PartialOrd for State {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        Some(self.cmp(other))
    }
}

impl Solution {
    pub fn network_delay_time(times: Vec<Vec<i32>>, n: i32, k: i32) -> i32 {
        let mut adj: HashMap<i32, Vec<(i32, i32)>> = HashMap::new();
        for time in times {
            let u = time[0];
            let v = time[1];
            let w = time[2];
            adj.entry(u).or_insert_with(Vec::new).push((v, w));
        }

        let mut dist: Vec<i32> = vec![i32::MAX; (n + 1) as usize];
        let mut pq = BinaryHeap::new();

        dist[k as usize] = 0;
        pq.push(State { cost: 0, position: k });

        while let Some(State { cost, position }) = pq.pop() {
            if cost > dist[position as usize] {
                continue;
            }

            if let Some(neighbors) = adj.get(&position) {
                for &(neighbor, weight) in neighbors {
                    if dist[position as usize] != i32::MAX && dist[position as usize] + weight < dist[neighbor as usize] {
                        dist[neighbor as usize] = dist[position as usize] + weight;
                        pq.push(State { cost: dist[neighbor as usize], position: neighbor });
                    }
                }
            }
        }

        let mut max_time = 0;
        for i in 1..=n {
            if dist[i as usize] == i32::MAX {
                return -1;
            }
            max_time = max_time.max(dist[i as usize]);
        }

        max_time
    }
}
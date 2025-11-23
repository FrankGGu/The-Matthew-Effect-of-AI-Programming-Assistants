impl Solution {

use std::collections::{BinaryHeap, HashMap};

#[derive(Copy, Clone, Eq, PartialEq, Hash)]
struct State {
    time: i32,
    room: usize,
}

impl Ord for State {
    fn cmp(&self, other: &Self) -> std::cmp::Ordering {
        other.time.cmp(&self.time)
    }
}

impl PartialOrd for State {
    fn partial_cmp(&self, other: &Self) -> Option<std::cmp::Ordering> {
        Some(self.cmp(other))
    }
}

impl Solution {
    pub fn min_time_to_reach_last_room(rooms: Vec<i32>) -> i32 {
        let n = rooms.len();
        let mut graph = vec![vec![]; n];
        for i in 0..n {
            if i + 1 < n {
                graph[i].push(i + 1);
            }
            if i > 0 {
                graph[i].push(i - 1);
            }
        }

        let mut dist = vec![i32::MAX; n];
        dist[0] = 0;
        let mut heap = BinaryHeap::new();
        heap.push(State { time: 0, room: 0 });

        while let Some(State { time, room }) = heap.pop() {
            if room == n - 1 {
                return time;
            }
            if time > dist[room] {
                continue;
            }
            for &neighbor in &graph[room] {
                let new_time = time + rooms[neighbor];
                if new_time < dist[neighbor] {
                    dist[neighbor] = new_time;
                    heap.push(State { time: new_time, room: neighbor });
                }
            }
        }

        dist[n - 1]
    }
}
}
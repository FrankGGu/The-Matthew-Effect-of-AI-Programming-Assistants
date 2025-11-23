impl Solution {

use std::collections::VecDeque;

struct Solution;

impl Solution {
    pub fn bus_rapid_transit(target: i32, forward: Vec<Vec<i32>>, backward: Vec<Vec<i32>>) -> i32 {
        use std::collections::{HashMap, VecDeque};

        let mut graph = HashMap::new();
        for edge in forward.iter() {
            let (u, v) = (edge[0], edge[1]);
            graph.entry(u).or_insert_with(Vec::new).push(v);
            graph.entry(v).or_insert_with(Vec::new).push(u);
        }
        for edge in backward.iter() {
            let (u, v) = (edge[0], edge[1]);
            graph.entry(u).or_insert_with(Vec::new).push(v);
            graph.entry(v).or_insert_with(Vec::new).push(u);
        }

        let mut visited = HashMap::new();
        let mut queue = VecDeque::new();
        queue.push_back((0, 0));
        visited.insert(0, 0);

        while let Some((station, time)) = queue.pop_front() {
            if station == target {
                return time;
            }
            if let Some(neighbors) = graph.get(&station) {
                for &next in neighbors {
                    if !visited.contains_key(&next) || time + 1 < *visited.get(&next).unwrap() {
                        visited.insert(next, time + 1);
                        queue.push_back((next, time + 1));
                    }
                }
            }
        }

        -1
    }
}
}
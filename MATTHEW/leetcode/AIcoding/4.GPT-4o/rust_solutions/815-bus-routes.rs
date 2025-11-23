use std::collections::{HashMap, HashSet, VecDeque};

pub struct Solution;

impl Solution {
    pub fn num_buses_to_destination(routes: Vec<Vec<i32>>, source: i32, target: i32) -> i32 {
        if source == target {
            return 0;
        }

        let mut graph: HashMap<i32, Vec<i32>> = HashMap::new();
        for (bus, route) in routes.iter().enumerate() {
            for &stop in route {
                graph.entry(stop).or_insert(vec![]).push(bus as i32);
            }
        }

        let mut visited_stops = HashSet::new();
        let mut visited_buses = HashSet::new();
        let mut queue = VecDeque::new();
        queue.push_back((source, 0));
        visited_stops.insert(source);

        while let Some((stop, buses)) = queue.pop_front() {
            if stop == target {
                return buses;
            }
            if let Some(buses_at_stop) = graph.get(&stop) {
                for &bus in buses_at_stop {
                    if !visited_buses.insert(bus) {
                        continue;
                    }
                    for &next_stop in &routes[bus as usize] {
                        if visited_stops.insert(next_stop) {
                            queue.push_back((next_stop, buses + 1));
                        }
                    }
                }
            }
        }

        -1
    }
}
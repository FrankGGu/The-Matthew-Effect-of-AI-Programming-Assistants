use std::collections::{HashMap, VecDeque};

impl Solution {
    pub fn num_buses_to_destination(routes: Vec<Vec<i32>>, source: i32, target: i32) -> i32 {
        if source == target {
            return 0;
        }

        let mut stop_to_buses: HashMap<i32, Vec<usize>> = HashMap::new();
        for (i, route) in routes.iter().enumerate() {
            for &stop in route {
                stop_to_buses.entry(stop).or_insert(Vec::new()).push(i);
            }
        }

        let mut queue: VecDeque<(usize, i32)> = VecDeque::new();
        let mut visited_buses: Vec<bool> = vec![false; routes.len()];

        if let Some(&buses) = stop_to_buses.get(&source) {
            for &bus in buses {
                queue.push_back((bus, 1));
                visited_buses[bus] = true;
            }
        }

        while let Some((bus, count)) = queue.pop_front() {
            for &stop in &routes[bus] {
                if stop == target {
                    return count;
                }
                if let Some(&next_buses) = stop_to_buses.get(&stop) {
                    for &next_bus in next_buses {
                        if !visited_buses[next_bus] {
                            queue.push_back((next_bus, count + 1));
                            visited_buses[next_bus] = true;
                        }
                    }
                }
            }
        }

        -1
    }
}
use std::collections::{HashMap, HashSet, VecDeque};

impl Solution {
    pub fn num_buses_to_destination(routes: Vec<Vec<i32>>, source: i32, target: i32) -> i32 {
        if source == target {
            return 0;
        }

        let mut stop_to_routes: HashMap<i32, Vec<usize>> = HashMap::new();
        for (i, route) in routes.iter().enumerate() {
            for &stop in route {
                stop_to_routes.entry(stop).or_insert_with(Vec::new).push(i);
            }
        }

        let mut queue: VecDeque<(usize, i32)> = VecDeque::new(); // (route_id, trips)
        let mut visited_routes: HashSet<usize> = HashSet::new();
        let mut visited_stops: HashSet<i32> = HashSet::new();

        if let Some(initial_routes) = stop_to_routes.get(&source) {
            for &route_id in initial_routes {
                if visited_routes.insert(route_id) {
                    queue.push_back((route_id, 1));
                }
            }
        } else {
            return -1;
        }

        while let Some((current_route_id, trips)) = queue.pop_front() {
            for &stop in &routes[current_route_id] {
                if stop == target {
                    return trips;
                }

                if visited_stops.insert(stop) {
                    if let Some(next_routes) = stop_to_routes.get(&stop) {
                        for &next_route_id in next_routes {
                            if visited_routes.insert(next_route_id) {
                                queue.push_back((next_route_id, trips + 1));
                            }
                        }
                    }
                }
            }
        }

        -1
    }
}
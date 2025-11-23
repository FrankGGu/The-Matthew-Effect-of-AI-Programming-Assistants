use std::collections::{HashMap, HashSet, VecDeque};

impl Solution {
    pub fn num_buses_to_destination(routes: Vec<Vec<i32>>, source: i32, target: i32) -> i32 {
        if source == target {
            return 0;
        }

        let mut stop_to_routes = HashMap::new();
        for (route_idx, route) in routes.iter().enumerate() {
            for &stop in route {
                stop_to_routes.entry(stop).or_insert_with(HashSet::new).insert(route_idx);
            }
        }

        let mut visited_routes = HashSet::new();
        let mut visited_stops = HashSet::new();
        let mut queue = VecDeque::new();

        if let Some(initial_routes) = stop_to_routes.get(&source) {
            for &route in initial_routes {
                queue.push_back((route, 1));
                visited_routes.insert(route);
            }
        }

        while let Some((route, buses)) = queue.pop_front() {
            for &stop in &routes[route] {
                if stop == target {
                    return buses;
                }
                if visited_stops.insert(stop) {
                    if let Some(connected_routes) = stop_to_routes.get(&stop) {
                        for &next_route in connected_routes {
                            if visited_routes.insert(next_route) {
                                queue.push_back((next_route, buses + 1));
                            }
                        }
                    }
                }
            }
        }

        -1
    }
}
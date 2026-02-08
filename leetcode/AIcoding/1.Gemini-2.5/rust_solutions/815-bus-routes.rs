use std::collections::{HashMap, VecDeque, HashSet};

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

        let mut queue: VecDeque<(usize, i32)> = VecDeque::new(); // (route_index, num_buses_taken)
        let mut visited_routes: HashSet<usize> = HashSet::new();

        // Initialize BFS with all routes that contain the source stop
        if let Some(initial_routes) = stop_to_routes.get(&source) {
            for &route_idx in initial_routes {
                queue.push_back((route_idx, 1));
                visited_routes.insert(route_idx);
            }
        } else {
            // Source stop is not on any route, so target is unreachable unless source == target (handled)
            return -1;
        }

        while let Some((current_route_idx, buses_taken)) = queue.pop_front() {
            // Check if target is on the current route
            for &stop in &routes[current_route_idx] {
                if stop == target {
                    return buses_taken;
                }
            }

            // Explore other routes reachable from the current route's stops
            for &stop in &routes[current_route_idx] {
                if let Some(connected_routes) = stop_to_routes.get(&stop) {
                    for &next_route_idx in connected_routes {
                        if visited_routes.insert(next_route_idx) { // Returns true if not present, false otherwise
                            queue.push_back((next_route_idx, buses_taken + 1));
                        }
                    }
                }
            }
        }

        -1
    }
}
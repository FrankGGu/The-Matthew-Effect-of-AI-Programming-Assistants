impl Solution {
    pub fn num_buses_to_destination(routes: Vec<Vec<i32>>, source: i32, target: i32) -> i32 {
        if source == target {
            return 0;
        }

        let mut graph = std::collections::HashMap::new();
        for (i, route) in routes.iter().enumerate() {
            for &stop in route {
                graph.entry(stop).or_insert(Vec::new()).push(i);
            }
        }

        let mut queue = std::collections::VecDeque::new();
        let mut visited_stops = std::collections::HashSet::new();
        let mut visited_routes = std::collections::HashSet::new();

        queue.push_back(source);
        visited_stops.insert(source);
        let mut buses = 0;

        while !queue.is_empty() {
            buses += 1;
            let size = queue.len();
            for _ in 0..size {
                let stop = queue.pop_front().unwrap();
                if let Some(routes) = graph.get(&stop) {
                    for &route in routes {
                        if visited_routes.insert(route) {
                            for &next_stop in &routes[route] {
                                if next_stop == target {
                                    return buses;
                                }
                                if visited_stops.insert(next_stop) {
                                    queue.push_back(next_stop);
                                }
                            }
                        }
                    }
                }
            }
        }

        -1
    }
}
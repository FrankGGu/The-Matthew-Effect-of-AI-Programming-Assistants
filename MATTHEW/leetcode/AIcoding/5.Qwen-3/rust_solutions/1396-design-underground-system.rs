impl Solution {

use std::collections::{HashMap, HashSet};

struct UndergroundSystem {
    check_ins: HashMap<i32, (String, String, i32)>,
    routes: HashMap<(String, String), (i32, i32)>,
}

impl UndergroundSystem {
    fn new() -> Self {
        UndergroundSystem {
            check_ins: HashMap::new(),
            routes: HashMap::new(),
        }
    }

    fn check_in(&mut self, id: i32, station_name: String, t: i32) {
        self.check_ins.insert(id, (station_name, String::new(), t));
    }

    fn check_out(&mut self, id: i32, station_name: String, t: i32) {
        if let Some((start_station, _, start_time)) = self.check_ins.get_mut(&id) {
            *start_station = std::mem::take(start_station);
            let duration = t - start_time;
            let route_key = (std::mem::take(start_station), station_name);
            let entry = self.routes.entry(route_key).or_insert((0, 0));
            entry.0 += duration;
            entry.1 += 1;
        }
    }

    fn get_average_time(&self, start_station: String, end_station: String) -> f64 {
        if let Some((total, count)) = self.routes.get(&(start_station, end_station)) {
            *total as f64 / *count as f64
        } else {
            0.0
        }
    }
}
}
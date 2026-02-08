use std::collections::hash_map::HashMap;

struct UndergroundSystem {
    check_in: HashMap<i32, (String, i32)>,
    travel_times: HashMap<(String, String), (i32, i32)>,
}

impl UndergroundSystem {
    fn new() -> Self {
        UndergroundSystem {
            check_in: HashMap::new(),
            travel_times: HashMap::new(),
        }
    }

    fn check_in(&mut self, id: i32, station_name: String, t: i32) {
        self.check_in.insert(id, (station_name, t));
    }

    fn check_out(&mut self, id: i32, station_name: String, t: i32) {
        if let Some((start_station, start_time)) = self.check_in.remove(&id) {
            let route = (start_station, station_name);
            let total_time = t - start_time;
            let (count, sum) = self.travel_times.entry(route).or_insert((0, 0));
            *count += 1;
            *sum += total_time;
        }
    }

    fn get_average_time(&self, start_station: String, end_station: String) -> f64 {
        if let Some(&(count, sum)) = self.travel_times.get(&(start_station, end_station)) {
            sum as f64 / count as f64
        } else {
            0.0
        }
    }
}
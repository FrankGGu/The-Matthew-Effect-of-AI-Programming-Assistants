use std::collections::HashMap;

struct UndergroundSystem {
    check_ins: HashMap<i32, (String, i32)>,
    travel_times: HashMap<(String, String), (i32, i32)>,
}

impl UndergroundSystem {
    fn new() -> Self {
        UndergroundSystem {
            check_ins: HashMap::new(),
            travel_times: HashMap::new(),
        }
    }

    fn check_in(&mut self, id: i32, station_name: String, t: i32) {
        self.check_ins.insert(id, (station_name, t));
    }

    fn check_out(&mut self, id: i32, station_name: String, t: i32) {
        if let Some((start_station, check_in_time)) = self.check_ins.remove(&id) {
            let travel_time = t - check_in_time;
            let key = (start_station, station_name);

            self.travel_times
                .entry(key)
                .and_modify(|(total_time, count)| {
                    *total_time += travel_time;
                    *count += 1;
                })
                .or_insert((travel_time, 1));
        }
    }

    fn get_average_time(&self, start_station: String, end_station: String) -> f64 {
        let key = (start_station, end_station);
        if let Some(&(total_time, count)) = self.travel_times.get(&key) {
            total_time as f64 / count as f64
        } else {
            0.0 // Should not happen based on problem constraints if called correctly
        }
    }
}
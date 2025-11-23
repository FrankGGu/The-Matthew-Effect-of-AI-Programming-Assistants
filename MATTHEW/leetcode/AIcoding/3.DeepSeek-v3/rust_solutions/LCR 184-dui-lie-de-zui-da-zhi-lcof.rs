use std::collections::HashMap;

struct CheckIn {
    station_name: String,
    time: i32,
}

struct UndergroundSystem {
    check_ins: HashMap<i32, CheckIn>,
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
        self.check_ins.insert(id, CheckIn { station_name, time: t });
    }

    fn check_out(&mut self, id: i32, station_name: String, t: i32) {
        if let Some(check_in) = self.check_ins.remove(&id) {
            let key = (check_in.station_name, station_name);
            let (total_time, count) = self.travel_times.entry(key).or_insert((0, 0));
            *total_time += t - check_in.time;
            *count += 1;
        }
    }

    fn get_average_time(&self, start_station: String, end_station: String) -> f64 {
        let key = (start_station, end_station);
        if let Some(&(total_time, count)) = self.travel_times.get(&key) {
            total_time as f64 / count as f64
        } else {
            0.0
        }
    }
}
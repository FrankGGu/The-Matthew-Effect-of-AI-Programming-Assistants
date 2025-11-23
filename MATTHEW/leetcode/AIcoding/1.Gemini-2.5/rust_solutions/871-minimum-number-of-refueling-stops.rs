use std::collections::BinaryHeap;

impl Solution {
    pub fn min_refuel_stops(target: i32, start_fuel: i32, stations: Vec<Vec<i32>>) -> i32 {
        let mut current_fuel: i64 = start_fuel as i64;
        let mut stops = 0;
        let mut prev_pos: i32 = 0;
        let mut pq = BinaryHeap::new();

        let mut all_stations = stations;
        all_stations.push(vec![target, 0]);

        for station in all_stations {
            let pos = station[0];
            let fuel = station[1];

            current_fuel -= (pos - prev_pos) as i64;

            while current_fuel < 0 {
                if let Some(f) = pq.pop() {
                    current_fuel += f as i64;
                    stops += 1;
                } else {
                    return -1;
                }
            }

            pq.push(fuel);
            prev_pos = pos;
        }

        stops
    }
}
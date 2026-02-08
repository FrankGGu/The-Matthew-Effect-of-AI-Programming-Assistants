impl Solution {
    pub fn min_refuel_stops(target: i32, start_fuel: i32, stations: Vec<Vec<i32>>) -> i32 {
        let mut pq = std::collections::BinaryHeap::new();
        let mut current_fuel = start_fuel;
        let mut stops = 0;
        let mut i = 0;

        while current_fuel < target {
            while i < stations.len() && stations[i][0] <= current_fuel {
                pq.push(stations[i][1]);
                i += 1;
            }

            if pq.is_empty() {
                return -1;
            }

            current_fuel += pq.pop().unwrap();
            stops += 1;
        }

        stops
    }
}
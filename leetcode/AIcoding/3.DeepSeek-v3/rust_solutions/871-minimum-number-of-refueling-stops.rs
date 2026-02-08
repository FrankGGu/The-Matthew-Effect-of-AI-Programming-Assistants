use std::collections::BinaryHeap;

impl Solution {
    pub fn min_refuel_stops(target: i32, start_fuel: i32, stations: Vec<Vec<i32>>) -> i32 {
        let mut max_heap = BinaryHeap::new();
        let mut fuel = start_fuel;
        let mut pos = 0;
        let mut res = 0;
        let mut i = 0;
        let n = stations.len();

        while pos + fuel < target {
            while i < n && stations[i][0] <= pos + fuel {
                max_heap.push(stations[i][1]);
                i += 1;
            }

            if max_heap.is_empty() {
                return -1;
            }

            fuel += max_heap.pop().unwrap();
            res += 1;
        }

        res
    }
}
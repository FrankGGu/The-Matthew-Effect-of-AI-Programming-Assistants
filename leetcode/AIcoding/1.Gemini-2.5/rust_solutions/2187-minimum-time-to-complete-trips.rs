impl Solution {
    pub fn minimum_time(time: Vec<i32>, total_trips: i64) -> i64 {
        let mut low: i64 = 1;
        let max_bus_time = *time.iter().max().unwrap() as i64;
        let mut high: i64 = max_bus_time * total_trips; 
        let mut ans: i64 = high;

        while low <= high {
            let mid = low + (high - low) / 2;
            if Self::can_complete(mid, &time, total_trips) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        ans
    }

    fn can_complete(time_limit: i64, bus_times: &[i32], total_trips_needed: i64) -> bool {
        let mut trips_completed: i64 = 0;
        for &bus_t in bus_times {
            trips_completed += time_limit / (bus_t as i64);
            if trips_completed >= total_trips_needed {
                return true;
            }
        }
        trips_completed >= total_trips_needed
    }
}
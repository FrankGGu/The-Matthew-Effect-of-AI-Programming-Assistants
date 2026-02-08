impl Solution {
    pub fn minimum_time(time: Vec<i32>, total_trips: i32) -> i64 {
        let mut left = 1;
        let mut right = *time.iter().min().unwrap() as i64 * total_trips as i64;
        let total_trips = total_trips as i64;

        while left < right {
            let mid = left + (right - left) / 2;
            let mut trips = 0;
            for &t in &time {
                trips += mid / t as i64;
            }

            if trips >= total_trips {
                right = mid;
            } else {
                left = mid + 1;
            }
        }

        left
    }
}
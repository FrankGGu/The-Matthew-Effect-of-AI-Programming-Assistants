impl Solution {
    pub fn minimum_time(time: Vec<i32>, total_trips: i32) -> i64 {
        let total_trips = total_trips as i64;
        let max_time = *time.iter().max().unwrap() as i64;
        let mut left = 1i64;
        let mut right = max_time * total_trips;

        while left < right {
            let mid = left + (right - left) / 2;
            let trips = time.iter().fold(0i64, |acc, &t| acc + mid / t as i64);

            if trips < total_trips {
                left = mid + 1;
            } else {
                right = mid;
            }
        }

        left
    }
}
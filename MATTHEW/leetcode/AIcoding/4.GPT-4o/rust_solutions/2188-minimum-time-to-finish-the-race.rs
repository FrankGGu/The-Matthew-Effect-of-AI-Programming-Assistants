pub fn minimum_time(time: Vec<i32>, total_trips: i32) -> i64 {
    let mut left = 1;
    let mut right = 1_000_000_000_000_000; // A large number to represent the maximum possible time
    let n = time.len() as i64;

    while left < right {
        let mid = left + (right - left) / 2;
        let trips = time.iter().map(|&t| mid / t as i64).sum::<i64>();

        if trips >= total_trips as i64 {
            right = mid;
        } else {
            left = mid + 1;
        }
    }
    left
}
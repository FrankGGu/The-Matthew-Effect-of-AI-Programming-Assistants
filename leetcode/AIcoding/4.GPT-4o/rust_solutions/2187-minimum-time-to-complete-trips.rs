pub fn minimum_time(time: Vec<i32>, total_trips: i32) -> i64 {
    let (mut left, mut right) = (1i64, time.iter().map(|&t| t as i64).min().unwrap() * total_trips as i64);

    while left < right {
        let mid = (left + right) / 2;
        let trips = time.iter().map(|&t| mid / t as i64).sum::<i64>();

        if trips < total_trips as i64 {
            left = mid + 1;
        } else {
            right = mid;
        }
    }

    left
}
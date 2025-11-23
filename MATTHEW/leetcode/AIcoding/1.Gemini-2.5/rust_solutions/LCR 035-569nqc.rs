impl Solution {
    pub fn find_min_difference(time_points: Vec<String>) -> i32 {
        let mut minutes: Vec<i32> = time_points
            .into_iter()
            .map(|s| {
                let parts: Vec<&str> = s.split(':').collect();
                let hour: i32 = parts[0].parse().unwrap();
                let minute: i32 = parts[1].parse().unwrap();
                hour * 60 + minute
            })
            .collect();

        minutes.sort_unstable();

        let mut min_diff = i32::MAX;
        let n = minutes.len();

        for i in 0..n - 1 {
            min_diff = min_diff.min(minutes[i + 1] - minutes[i]);
        }

        // Handle wrap-around difference
        min_diff = min_diff.min(1440 - minutes[n - 1] + minutes[0]);

        min_diff
    }
}
impl Solution {
    pub fn find_min_difference(time_points: Vec<String>) -> i32 {
        let mut minutes: Vec<i32> = time_points
            .iter()
            .map(|s| {
                let parts: Vec<&str> = s.split(':').collect();
                let hour: i32 = parts[0].parse().unwrap();
                let minute: i32 = parts[1].parse().unwrap();
                hour * 60 + minute
            })
            .collect();

        minutes.sort();

        let mut min_diff = i32::MAX;
        for i in 0..minutes.len() - 1 {
            min_diff = min_diff.min(minutes[i + 1] - minutes[i]);
        }

        min_diff = min_diff.min(minutes[0] + 1440 - minutes[minutes.len() - 1]);

        min_diff
    }
}
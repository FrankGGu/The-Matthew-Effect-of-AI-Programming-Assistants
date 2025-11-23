impl Solution {
    pub fn find_min_difference(time_points: Vec<String>) -> i32 {
        let mut minutes: Vec<i32> = time_points
            .iter()
            .map(|time| {
                let parts: Vec<&str> = time.split(':').collect();
                parts[0].parse::<i32>().unwrap() * 60 + parts[1].parse::<i32>().unwrap()
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
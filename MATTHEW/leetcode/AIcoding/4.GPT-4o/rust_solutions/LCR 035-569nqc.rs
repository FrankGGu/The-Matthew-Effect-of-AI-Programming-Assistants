use std::collections::HashSet;

impl Solution {
    pub fn find_min_difference(time_points: Vec<String>) -> i32 {
        let mut minutes = vec![];

        for time in time_points {
            let parts: Vec<&str> = time.split(':').collect();
            let total_minutes = parts[0].parse::<i32>().unwrap() * 60 + parts[1].parse::<i32>().unwrap();
            minutes.push(total_minutes);
        }

        minutes.sort();
        let mut min_diff = i32::MAX;

        for i in 1..minutes.len() {
            min_diff = min_diff.min(minutes[i] - minutes[i - 1]);
        }

        min_diff = min_diff.min(1440 + minutes[0] - minutes[minutes.len() - 1]);

        min_diff
    }
}
use std::collections::HashSet;

impl Solution {
    pub fn find_min_difference(time_points: Vec<String>) -> i32 {
        let mut minutes = Vec::new();
        for time in time_points {
            let parts: Vec<&str> = time.split(':').collect();
            let total_minutes = parts[0].parse::<i32>().unwrap() * 60 + parts[1].parse::<i32>().unwrap();
            minutes.push(total_minutes);
        }
        minutes.sort();

        let mut min_diff = i32::MAX;
        let n = minutes.len();

        for i in 0..n {
            let diff = if i == n - 1 {
                (minutes[0] + 1440) - minutes[i]
            } else {
                minutes[i + 1] - minutes[i]
            };
            min_diff = min_diff.min(diff);
        }

        min_diff
    }
}
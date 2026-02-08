impl Solution {
    pub fn find_min_difference(time_points: Vec<String>) -> i32 {
        let mut minutes: Vec<i32> = Vec::with_capacity(time_points.len());

        for time_str in time_points {
            let parts: Vec<&str> = time_str.split(':').collect();
            let hours: i32 = parts[0].parse().unwrap();
            let mins: i32 = parts[1].parse().unwrap();
            minutes.push(hours * 60 + mins);
        }

        minutes.sort_unstable();

        let mut min_diff = 1440; 

        for i in 1..minutes.len() {
            min_diff = min_diff.min(minutes[i] - minutes[i - 1]);
        }

        min_diff = min_diff.min(minutes[0] + 1440 - minutes[minutes.len() - 1]);

        min_diff
    }
}
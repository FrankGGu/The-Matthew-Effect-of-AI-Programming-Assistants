impl Solution {
    pub fn slowest_key(release_times: Vec<i32>, keys_pressed: String) -> char {
        let mut max_duration = 0;
        let mut slowest_key = ' ';

        for i in 0..keys_pressed.len() {
            let duration = if i == 0 {
                release_times[i]
            } else {
                release_times[i] - release_times[i - 1]
            };

            if duration > max_duration || (duration == max_duration && keys_pressed.chars().nth(i).unwrap() > slowest_key) {
                max_duration = duration;
                slowest_key = keys_pressed.chars().nth(i).unwrap();
            }
        }

        slowest_key
    }
}
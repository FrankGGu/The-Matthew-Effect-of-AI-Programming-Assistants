impl Solution {
    pub fn slowest_key(release_times: Vec<i32>, keys_pressed: String) -> char {
        let n = release_times.len();
        let keys: Vec<char> = keys_pressed.chars().collect();

        let mut max_duration = release_times[0];
        let mut result_key = keys[0];

        for i in 1..n {
            let current_duration = release_times[i] - release_times[i - 1];
            if current_duration > max_duration {
                max_duration = current_duration;
                result_key = keys[i];
            } else if current_duration == max_duration {
                if keys[i] > result_key {
                    result_key = keys[i];
                }
            }
        }
        result_key
    }
}
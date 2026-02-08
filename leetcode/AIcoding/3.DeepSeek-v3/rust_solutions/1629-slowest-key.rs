impl Solution {
    pub fn slowest_key(release_times: Vec<i32>, keys_pressed: String) -> char {
        let mut max_duration = release_times[0];
        let mut result = keys_pressed.chars().nth(0).unwrap();

        for i in 1..release_times.len() {
            let duration = release_times[i] - release_times[i - 1];
            if duration > max_duration {
                max_duration = duration;
                result = keys_pressed.chars().nth(i).unwrap();
            } else if duration == max_duration {
                let current_char = keys_pressed.chars().nth(i).unwrap();
                if current_char > result {
                    result = current_char;
                }
            }
        }

        result
    }
}
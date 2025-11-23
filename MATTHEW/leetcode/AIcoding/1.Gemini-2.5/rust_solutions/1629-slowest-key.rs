impl Solution {
    pub fn slowest_key(release_times: Vec<i32>, keys_pressed: String) -> char {
        let mut max_duration = 0;
        let mut slowest_key_char = ' ';

        let mut prev_release_time = 0;

        let mut keys_iter = keys_pressed.chars();

        for &current_release_time in release_times.iter() {
            let current_key_char = keys_iter.next().unwrap();

            let current_duration = current_release_time - prev_release_time;

            if current_duration > max_duration {
                max_duration = current_duration;
                slowest_key_char = current_key_char;
            } else if current_duration == max_duration {
                if current_key_char > slowest_key_char {
                    slowest_key_char = current_key_char;
                }
            }

            prev_release_time = current_release_time;
        }

        slowest_key_char
    }
}
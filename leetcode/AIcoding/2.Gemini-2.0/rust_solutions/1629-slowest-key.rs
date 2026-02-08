impl Solution {
    pub fn slowest_key(release_times: Vec<i32>, keys_pressed: String) -> char {
        let mut max_duration = release_times[0];
        let mut slowest_key = keys_pressed.chars().nth(0).unwrap();

        for i in 1..release_times.len() {
            let duration = release_times[i] - release_times[i - 1];
            let key = keys_pressed.chars().nth(i).unwrap();

            if duration > max_duration {
                max_duration = duration;
                slowest_key = key;
            } else if duration == max_duration && key > slowest_key {
                slowest_key = key;
            }
        }

        slowest_key
    }
}
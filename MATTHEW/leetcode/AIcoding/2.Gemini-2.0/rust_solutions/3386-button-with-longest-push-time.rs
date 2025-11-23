impl Solution {
    pub fn longest_press(release_times: Vec<i32>, keys_pressed: String) -> char {
        let mut max_time = release_times[0];
        let mut max_char = keys_pressed.chars().nth(0).unwrap();
        let keys: Vec<char> = keys_pressed.chars().collect();

        for i in 1..release_times.len() {
            let diff = release_times[i] - release_times[i - 1];
            if diff > max_time {
                max_time = diff;
                max_char = keys[i];
            } else if diff == max_time && keys[i] > max_char {
                max_char = keys[i];
            }
        }

        max_char
    }
}
impl Solution {

use std::cmp::Ordering;

struct Solution {}

impl Solution {
    pub fn hardest_button(releaseTimes: Vec<i32>, keysPressed: String) -> char {
        let mut max_duration = 0;
        let mut result_char = 'a';
        let mut prev_time = 0;

        for (i, c) in keysPressed.chars().enumerate() {
            let duration = releaseTimes[i] - prev_time;
            match duration.cmp(&max_duration) {
                Ordering::Greater => {
                    max_duration = duration;
                    result_char = c;
                }
                Ordering::Equal => {
                    if c < result_char {
                        result_char = c;
                    }
                }
                _ => {}
            }
            prev_time = releaseTimes[i];
        }

        result_char
    }
}
}
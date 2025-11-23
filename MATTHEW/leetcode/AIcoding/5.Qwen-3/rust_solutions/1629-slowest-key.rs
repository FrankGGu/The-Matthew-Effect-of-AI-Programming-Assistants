impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn slowest_key(key_times: Vec<Vec<i32>>) -> char {
        let mut max_duration = 0;
        let mut result_char = 'a';
        let mut prev_time = 0;

        for times in key_times {
            let key = (b'a' + times[0] as u8) as char;
            let duration = times[1] - prev_time;
            if duration > max_duration {
                max_duration = duration;
                result_char = key;
            } else if duration == max_duration && key < result_char {
                result_char = key;
            }
            prev_time = times[1];
        }

        result_char
    }
}
}
use std::collections::HashMap;

impl Solution {
    pub fn rearrange_characters(s: String, target: String) -> i32 {
        let mut s_counts = [0; 26];
        for c in s.chars() {
            s_counts[(c as u8 - b'a') as usize] += 1;
        }

        let mut target_counts = [0; 26];
        for c in target.chars() {
            target_counts[(c as u8 - b'a') as usize] += 1;
        }

        let mut max_possible_times = i32::MAX;

        for i in 0..26 {
            if target_counts[i] > 0 {
                let available = s_counts[i];
                let required = target_counts[i];
                max_possible_times = max_possible_times.min(available / required);
            }
        }

        max_possible_times
    }
}
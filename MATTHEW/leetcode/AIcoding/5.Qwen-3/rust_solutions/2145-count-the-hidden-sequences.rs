impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn count_hidden_sequences(s: String) -> i32 {
        let s_bytes = s.as_bytes();
        let n = s_bytes.len();
        let mut dp = HashMap::new();
        dp.insert(0, 1);

        for i in 1..n {
            let mut new_dp = HashMap::new();
            let prev_char = s_bytes[i - 1] as i32;
            let curr_char = s_bytes[i] as i32;
            let diff = (prev_char - curr_char).abs();

            if diff == 1 {
                for (&key, &count) in &dp {
                    new_dp.entry(key + 1).and_modify(|e| *e += count).or_insert(count);
                    new_dp.entry(key - 1).and_modify(|e| *e += count).or_insert(count);
                }
            } else {
                for (&key, &count) in &dp {
                    new_dp.entry(key).and_modify(|e| *e += count).or_insert(count);
                }
            }

            dp = new_dp;
        }

        dp.values().sum::<i32>()
    }
}
}
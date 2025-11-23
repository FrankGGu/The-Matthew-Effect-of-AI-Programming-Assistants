impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn maximum_length(s: String) -> i32 {
        let mut freq = HashMap::new();
        let n = s.len();

        for i in 0..n {
            let mut j = i;
            while j < n && s.chars().nth(i) == s.chars().nth(j) {
                j += 1;
            }
            let len = j - i;
            for k in 1..=len {
                *freq.entry(k).or_insert(0) += len - k + 1;
            }
        }

        let mut max_len = -1;
        for (&k, &count) in &freq {
            if count >= 3 {
                max_len = std::cmp::max(max_len, k as i32);
            }
        }

        max_len
    }
}
}
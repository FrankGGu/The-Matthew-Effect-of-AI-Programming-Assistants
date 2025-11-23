impl Solution {

use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn max_number_of_non_overlapping_substrings(s: String) -> i32 {
        let mut first = vec![-1; 26];
        let mut last = vec![-1; 26];
        for (i, c) in s.chars().enumerate() {
            let idx = (c as u8 - b'a') as usize;
            if first[idx] == -1 {
                first[idx] = i as i32;
            }
            last[idx] = i as i32;
        }

        let mut intervals = Vec::new();
        for i in 0..26 {
            if first[i] != -1 {
                intervals.push((first[i], last[i]));
            }
        }

        intervals.sort_by(|a, b| a.1.cmp(&b.1));

        let mut res = 0;
        let mut prev_end = -1;
        for (start, end) in intervals {
            if start > prev_end {
                res += 1;
                prev_end = end;
            }
        }

        res
    }
}
}
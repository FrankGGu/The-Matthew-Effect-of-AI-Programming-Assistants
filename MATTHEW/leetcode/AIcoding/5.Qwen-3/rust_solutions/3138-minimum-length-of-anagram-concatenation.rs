impl Solution {

use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn min_anagram_concatenation(s: String, t: String) -> i32 {
        let mut count = HashMap::new();
        for c in s.chars() {
            *count.entry(c).or_insert(0) += 1;
        }
        for c in t.chars() {
            *count.entry(c).or_insert(0) -= 1;
        }

        let mut required = 0;
        for &v in count.values() {
            if v > 0 {
                required += v;
            }
        }

        if required == 0 {
            return 0;
        }

        let mut freq = HashMap::new();
        let mut left = 0;
        let mut res = i32::MAX;
        for (right, c) in s.chars().enumerate() {
            *freq.entry(c).or_insert(0) += 1;

            while freq.get(&c).unwrap() > count.get(&c).unwrap_or(&0) {
                let left_char = s.chars().nth(left).unwrap();
                *freq.get_mut(&left_char).unwrap() -= 1;
                left += 1;
            }

            if right - left + 1 >= t.len() {
                let mut valid = true;
                for (k, &v) in &count {
                    if *freq.get(k).unwrap_or(&0) < v {
                        valid = false;
                        break;
                    }
                }
                if valid {
                    res = std::cmp::min(res, (right - left + 1) as i32);
                }
            }
        }

        res
    }
}
}
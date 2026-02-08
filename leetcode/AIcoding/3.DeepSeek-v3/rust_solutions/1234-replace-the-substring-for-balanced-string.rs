use std::collections::HashMap;
use std::cmp;

impl Solution {
    pub fn balanced_string(s: String) -> i32 {
        let s = s.as_bytes();
        let n = s.len();
        let target = n / 4;
        let mut count = HashMap::new();

        for &c in s {
            *count.entry(c).or_insert(0) += 1;
        }

        if count.values().all(|&v| v == target) {
            return 0;
        }

        let mut res = n as i32;
        let mut left = 0;

        for right in 0..n {
            *count.get_mut(&s[right]).unwrap() -= 1;

            while left <= right && count.values().all(|&v| v <= target) {
                res = cmp::min(res, (right - left + 1) as i32);
                *count.get_mut(&s[left]).unwrap() += 1;
                left += 1;
            }
        }

        res
    }
}
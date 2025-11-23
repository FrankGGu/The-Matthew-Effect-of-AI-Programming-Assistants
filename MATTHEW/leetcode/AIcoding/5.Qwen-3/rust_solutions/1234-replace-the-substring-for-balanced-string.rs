impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn replace_substring(s: String, k: i32) -> i32 {
        let mut count = HashMap::new();
        let mut left = 0;
        let mut max_freq = 0;
        let n = s.len();
        let k = k as usize;

        for right in 0..n {
            let c = s.as_bytes()[right];
            *count.entry(c).or_insert(0) += 1;
            max_freq = std::cmp::max(max_freq, *count.get(&c).unwrap());

            if right - left + 1 > k {
                let left_c = s.as_bytes()[left];
                *count.get_mut(&left_c).unwrap() -= 1;
                if *count.get(&left_c).unwrap() == 0 {
                    count.remove(&left_c);
                }
                left += 1;
            }

            if right - left + 1 == k {
                if max_freq + 1 >= k {
                    return (right - left + 1) as i32;
                }
            }
        }

        -1
    }
}
}
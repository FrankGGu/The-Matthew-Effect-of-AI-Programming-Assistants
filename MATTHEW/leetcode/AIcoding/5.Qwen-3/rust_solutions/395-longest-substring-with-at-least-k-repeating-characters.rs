impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn longest_substring(s: String, k: i32) -> i32 {
        fn helper(s: &str, k: i32) -> i32 {
            if s.len() < k as usize {
                return 0;
            }
            let mut count = HashMap::new();
            for c in s.chars() {
                *count.entry(c).or_insert(0) += 1;
            }
            let mut split = None;
            for (i, c) in s.chars().enumerate() {
                if count[&c] < k {
                    split = Some(i);
                    break;
                }
            }
            match split {
                None => return s.len() as i32,
                Some(i) => {
                    let left = helper(&s[..i], k);
                    let right = helper(&s[i + 1..], k);
                    return left.max(right);
                }
            }
        }
        helper(&s, k)
    }
}
}
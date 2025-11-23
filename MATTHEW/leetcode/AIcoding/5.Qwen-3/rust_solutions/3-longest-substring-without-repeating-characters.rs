impl Solution {

use std::collections::HashSet;

struct Solution;

impl Solution {
    pub fn length_of_longest_substring(s: String) -> i32 {
        let mut max_length = 0;
        let mut left = 0;
        let mut seen = HashSet::new();
        let chars: Vec<char> = s.chars().collect();

        for right in 0..chars.len() {
            while seen.contains(&chars[right]) {
                seen.remove(&chars[left]);
                left += 1;
            }
            seen.insert(chars[right]);
            max_length = max_length.max(right - left + 1);
        }

        max_length as i32
    }
}
}
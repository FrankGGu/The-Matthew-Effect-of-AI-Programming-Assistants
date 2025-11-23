use std::collections::HashMap;

impl Solution {
    pub fn longest_palindrome(s: String) -> i32 {
        let mut count = HashMap::new();
        for c in s.chars() {
            *count.entry(c).or_insert(0) += 1;
        }
        let mut length = 0;
        let mut has_odd = false;
        for &v in count.values() {
            length += v / 2 * 2;
            if v % 2 == 1 {
                has_odd = true;
            }
        }
        if has_odd {
            length += 1;
        }
        length
    }
}
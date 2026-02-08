impl Solution {
    pub fn longest_palindrome(s: String) -> i32 {
        use std::collections::HashMap;

        let mut counts: HashMap<char, i32> = HashMap::new();
        for c in s.chars() {
            *counts.entry(c).or_insert(0) += 1;
        }

        let mut length = 0;
        let mut has_odd = false;

        for &count in counts.values() {
            if count % 2 == 0 {
                length += count;
            } else {
                length += count - 1;
                has_odd = true;
            }
        }

        if has_odd {
            length + 1
        } else {
            length
        }
    }
}
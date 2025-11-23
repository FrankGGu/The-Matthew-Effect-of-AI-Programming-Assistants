impl Solution {

use std::collections::HashSet;

struct Solution {}

impl Solution {
    pub fn can_win(num: i32) -> bool {
        let num_str = num.to_string();
        let mut seen = HashSet::new();
        let mut current = 0;

        for c in num_str.chars() {
            let digit = c as i32 - '0' as i32;
            if seen.contains(&digit) {
                return false;
            }
            seen.insert(digit);
            current += digit;
        }

        current % 2 == 0
    }
}
}
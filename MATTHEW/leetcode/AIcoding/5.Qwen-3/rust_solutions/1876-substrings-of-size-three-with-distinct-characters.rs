impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn count_good_substrings(s: String) -> i32 {
        let mut count = 0;
        let chars: Vec<char> = s.chars().collect();

        for i in 0..chars.len() - 2 {
            let a = chars[i];
            let b = chars[i + 1];
            let c = chars[i + 2];

            if a != b && b != c && a != c {
                count += 1;
            }
        }

        count
    }
}
}
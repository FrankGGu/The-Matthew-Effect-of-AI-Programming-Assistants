impl Solution {

use std::cmp::max;

impl Solution {
    pub fn max_vowels(s: String, k: i32) -> i32 {
        let s = s.as_bytes();
        let mut max_count = 0;
        let mut current_count = 0;
        let vowels = ['a', 'e', 'i', 'o', 'u'];

        for i in 0..s.len() {
            if vowels.contains(&s[i] as &u8) {
                current_count += 1;
            }

            if i >= k as usize {
                if vowels.contains(&s[i - k as usize] as &u8) {
                    current_count -= 1;
                }
            }

            max_count = max(max_count, current_count);
        }

        max_count
    }
}
}
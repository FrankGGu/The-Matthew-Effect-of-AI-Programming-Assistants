impl Solution {

use std::collections::HashSet;

struct Solution;

impl Solution {
    pub fn reverse_vowels(s: String) -> String {
        let vowels: HashSet<char> = ['a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U'].iter().cloned().collect();
        let mut chars: Vec<char> = s.chars().collect();
        let mut left = 0;
        let mut right = chars.len() - 1;

        while left < right {
            if !vowels.contains(&chars[left]) {
                left += 1;
            } else if !vowels.contains(&chars[right]) {
                right -= 1;
            } else {
                chars.swap(left, right);
                left += 1;
                right -= 1;
            }
        }

        chars.into_iter().collect()
    }
}
}
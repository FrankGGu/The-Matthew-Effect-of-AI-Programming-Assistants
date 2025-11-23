impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn min_moves_to_make_palindrome(mut s: String) -> i32 {
        let mut s: Vec<char> = s.chars().collect();
        let mut result = 0;
        let mut left = 0;
        let mut right = s.len() - 1;

        while left < right {
            if s[left] == s[right] {
                left += 1;
                right -= 1;
                continue;
            }

            let mut j = right;
            while j > left && s[j] != s[left] {
                j -= 1;
            }

            if j == left {
                s.swap(left, left + 1);
                result += 1;
                continue;
            }

            while j < right {
                s.swap(j, j + 1);
                result += 1;
                j += 1;
            }

            left += 1;
            right -= 1;
        }

        result
    }
}
}
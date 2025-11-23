impl Solution {

use std::cmp;

impl Solution {
    pub fn is_palindrome(s: &str, left: usize, right: usize) -> bool {
        let s_bytes = s.as_bytes();
        while left < right {
            if s_bytes[left] != s_bytes[right] {
                return false;
            }
            left += 1;
            right -= 1;
        }
        true
    }

    pub fn check_prefix_suffix(s: &str, t: &str) -> bool {
        let mut i = 0;
        let mut j = t.len() - 1;
        while i < s.len() && j >= 0 {
            if s.as_bytes()[i] != t.as_bytes()[j] {
                break;
            }
            i += 1;
            j -= 1;
        }
        if i >= s.len() || j < 0 {
            return true;
        }
        let left = i;
        let right = t.len() - 1 - j;
        Self::is_palindrome(t, j + 1, t.len() - 1) || Self::is_palindrome(s, left, s.len() - 1)
    }

    pub fn can_split_to_palindrome(s: &str, t: &str) -> bool {
        Self::check_prefix_suffix(s, t) || Self::check_prefix_suffix(t, s)
    }
}

pub struct Solution;
}
impl Solution {

use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn longest_dup_substring(s: String) -> String {
        let s: Vec<char> = s.chars().collect();
        let n = s.len();
        let mut left = 0;
        let mut right = n - 1;
        let mut result = String::new();

        while left <= right {
            let mid = (left + right) / 2;
            if let Some(sub) = Self::find_duplicate(&s, mid) {
                result = sub;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        result
    }

    fn find_duplicate(s: &[char], length: usize) -> Option<String> {
        let n = s.len();
        let base = 26;
        let mod_val = 1 << 61;
        let mut seen = HashMap::new();
        let mut hash = 0;
        let mut power = 1;

        for i in 0..length {
            hash = (hash * base + s[i] as u64) % mod_val;
            power = (power * base) % mod_val;
        }

        seen.insert(hash, 0);

        for i in 1..=n - length {
            hash = (hash * base - s[i - 1] as u64 * power + s[i + length - 1] as u64) % mod_val;
            if hash < 0 {
                hash += mod_val;
            }

            if let Some(&start) = seen.get(&hash) {
                if s[start..start + length] == s[i..i + length] {
                    return Some(s[i..i + length].iter().collect());
                }
            } else {
                seen.insert(hash, i);
            }
        }

        None
    }
}
}
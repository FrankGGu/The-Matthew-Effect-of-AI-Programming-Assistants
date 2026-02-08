pub struct Solution;

impl Solution {
    pub fn longest_dup_substring(s: String) -> String {
        let s_bytes = s.as_bytes();
        let n = s.len();
        let mut left = 1;
        let mut right = n;

        let mut result = "";

        while left < right {
            let mid = left + (right - left) / 2;
            if let Some(substr) = Self::search(s_bytes, mid) {
                result = substr;
                left = mid + 1;
            } else {
                right = mid;
            }
        }

        result.to_string()
    }

    fn search(s: &[u8], length: usize) -> Option<&str> {
        use std::collections::HashSet;

        let mut seen = HashSet::new();
        let mut hash = 0;
        let base: u64 = 256;
        let mod_val: u64 = 1_000_000_007;
        let mut base_l = 1;

        for i in 0..length {
            hash = (hash * base + s[i] as u64) % mod_val;
            if i < length - 1 {
                base_l = (base_l * base) % mod_val;
            }
        }

        seen.insert(hash);

        for start in 1..=s.len() - length {
            hash = (hash * base - s[start - 1] as u64 * base_l + s[start + length - 1] as u64) % mod_val;
            if hash < 0 {
                hash += mod_val;
            }
            if seen.contains(&hash) {
                return Some(std::str::from_utf8(&s[start..start + length]).unwrap());
            }
            seen.insert(hash);
        }

        None
    }
}
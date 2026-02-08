use std::collections::HashSet;

impl Solution {
    pub fn longest_dup_substring(s: String) -> String {
        let s = s.as_bytes();
        let n = s.len();
        let mut left = 1;
        let mut right = n;
        let mut answer = "";

        while left <= right {
            let mid = left + (right - left) / 2;
            if let Some(dup) = Self::has_duplicate(s, mid) {
                answer = dup;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        answer.to_string()
    }

    fn has_duplicate(s: &[u8], len: usize) -> Option<&str> {
        let n = s.len();
        let base = 26;
        let modulus = 1_000_000_007;
        let mut hash = 0;
        let mut power = 1;

        for i in 0..len {
            hash = (hash * base + (s[i] - b'a') as u64) % modulus;
            power = (power * base) % modulus;
        }

        let mut seen = HashSet::new();
        seen.insert(hash);

        for i in len..n {
            hash = (hash * base + (s[i] - b'a') as u64 - (s[i - len] - b'a') as u64 * power) % modulus;
            if hash < 0 {
                hash += modulus;
            }
            if seen.contains(&hash) {
                return Some(std::str::from_utf8(&s[i - len + 1..=i]).unwrap());
            }
            seen.insert(hash);
        }

        None
    }
}
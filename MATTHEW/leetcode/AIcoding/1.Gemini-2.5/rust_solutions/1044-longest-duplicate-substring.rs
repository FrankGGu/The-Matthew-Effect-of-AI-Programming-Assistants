use std::collections::HashSet;

struct Solution;

impl Solution {
    pub fn longest_duplicate_substring(s: String) -> String {
        let n = s.len();
        if n == 0 {
            return "".to_string();
        }

        let s_bytes: Vec<u32> = s.bytes().map(|c| (c - b'a' + 1) as u32).collect();

        let base: u64 = 29;

        let mut low = 0;
        let mut high = n as i32 - 1;
        let mut ans_len = 0;
        let mut ans_start_idx = 0;

        while low <= high {
            let mid_len = low + (high - low) / 2;

            match Self::check_for_duplicate(&s_bytes, mid_len, base) {
                Some(start_idx) => {
                    ans_len = mid_len;
                    ans_start_idx = start_idx;
                    low = mid_len + 1;
                }
                None => {
                    high = mid_len - 1;
                }
            }
        }

        s[ans_start_idx..ans_start_idx + ans_len as usize].to_string()
    }

    fn check_for_duplicate(s_bytes: &[u32], len: i32, base: u64) -> Option<usize> {
        let n = s_bytes.len();
        let len_usize = len as usize;

        if len == 0 {
            return Some(0);
        }
        if len_usize > n {
            return None;
        }

        let mut power_of_base_minus_1 = 1;
        for _ in 0..(len_usize - 1) {
            power_of_base_minus_1 = power_of_base_minus_1.wrapping_mul(base);
        }

        let mut current_hash = 0;
        for i in 0..len_usize {
            current_hash = current_hash.wrapping_mul(base).wrapping_add(s_bytes[i] as u64);
        }

        let mut seen_hashes: HashSet<u64> = HashSet::new();
        seen_hashes.insert(current_hash);

        for i in 1..=n - len_usize {
            current_hash = current_hash
                .wrapping_sub(s_bytes[i - 1] as u64 * power_of_base_minus_1)
                .wrapping_mul(base)
                .wrapping_add(s_bytes[i + len_usize - 1] as u64);

            if seen_hashes.contains(&current_hash) {
                return Some(i);
            }
            seen_hashes.insert(current_hash);
        }

        None
    }
}
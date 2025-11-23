use std::collections::HashSet;

const BASE1: u64 = 31;
const MOD1: u64 = 1_000_000_007;
const BASE2: u64 = 37;
const MOD2: u64 = 1_000_000_009;

struct Solution;

impl Solution {
    fn get_hashes(s: &str, length: usize) -> HashSet<(u64, u64)> {
        let n = s.len();
        if length == 0 || length > n {
            return HashSet::new();
        }

        let s_bytes = s.as_bytes();

        let mut pow1 = 1;
        let mut pow2 = 1;
        for _ in 0..length {
            pow1 = (pow1 * BASE1) % MOD1;
            pow2 = (pow2 * BASE2) % MOD2;
        }

        let mut current_hash1 = 0;
        let mut current_hash2 = 0;

        for i in 0..length {
            let char_val = (s_bytes[i] - b'a' + 1) as u64;
            current_hash1 = (current_hash1 * BASE1 + char_val) % MOD1;
            current_hash2 = (current_hash2 * BASE2 + char_val) % MOD2;
        }

        let mut hashes = HashSet::new();
        hashes.insert((current_hash1, current_hash2));

        for i in length..n {
            let prev_char_val = (s_bytes[i - length] - b'a' + 1) as u64;
            let current_char_val = (s_bytes[i] - b'a' + 1) as u64;

            current_hash1 = (current_hash1 * BASE1 - (prev_char_val * pow1) % MOD1 + MOD1) % MOD1;
            current_hash1 = (current_hash1 + current_char_val) % MOD1;

            current_hash2 = (current_hash2 * BASE2 - (prev_char_val * pow2) % MOD2 + MOD2) % MOD2;
            current_hash2 = (current_hash2 + current_char_val) % MOD2;

            hashes.insert((current_hash1, current_hash2));
        }

        hashes
    }

    fn check(len: usize, strs: &[String]) -> bool {
        if len == 0 {
            return true;
        }

        let mut common_hashes = Self::get_hashes(&strs[0], len);
        if common_hashes.is_empty() {
            return false;
        }

        for i in 1..strs.len() {
            let current_string_hashes = Self::get_hashes(&strs[i], len);
            if current_string_hashes.is_empty() {
                return false;
            }

            let mut new_common_hashes = HashSet::new();
            for h in current_string_hashes.iter() {
                if common_hashes.contains(h) {
                    new_common_hashes.insert(*h);
                }
            }
            common_hashes = new_common_hashes;
            if common_hashes.is_empty() {
                return false;
            }
        }

        true
    }

    pub fn longest_common_prefix_of_k_strings_after_removal(strs: Vec<String>) -> i32 {
        if strs.is_empty() {
            return 0;
        }

        let mut min_len = usize::MAX;
        for s in &strs {
            min_len = min_len.min(s.len());
        }

        let mut low = 0;
        let mut high = min_len;
        let mut ans = 0;

        while low <= high {
            let mid = low + (high - low) / 2;
            if Self::check(mid, &strs) {
                ans = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }

        ans as i32
    }
}
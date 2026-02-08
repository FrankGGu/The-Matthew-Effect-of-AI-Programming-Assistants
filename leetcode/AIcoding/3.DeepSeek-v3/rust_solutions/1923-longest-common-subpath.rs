use std::collections::HashMap;

const MOD: i64 = 1_000_000_007;
const BASE: i64 = 911382629;

struct Solution;

impl Solution {
    pub fn longest_common_subpath(n: i32, paths: Vec<Vec<i32>>) -> i32 {
        let mut left = 0;
        let mut right = paths.iter().map(|p| p.len()).min().unwrap();
        let mut answer = 0;

        while left <= right {
            let mid = (left + right) / 2;
            if Self::has_common_subpath(mid, &paths) {
                answer = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        answer as i32
    }

    fn has_common_subpath(len: usize, paths: &[Vec<i32>]) -> bool {
        if len == 0 {
            return true;
        }

        let mut base_pow = 1;
        for _ in 1..len {
            base_pow = (base_pow * BASE) % MOD;
        }

        let mut hash_map = HashMap::new();
        for (i, path) in paths.iter().enumerate() {
            if path.len() < len {
                return false;
            }

            let mut current_hash = 0;
            for j in 0..len {
                current_hash = (current_hash * BASE + path[j] as i64) % MOD;
            }

            let mut seen = HashMap::new();
            seen.insert(current_hash, true);

            for j in len..path.len() {
                current_hash = (current_hash - path[j - len] as i64 * base_pow % MOD + MOD) % MOD;
                current_hash = (current_hash * BASE + path[j] as i64) % MOD;
                seen.insert(current_hash, true);
            }

            if i == 0 {
                for (&hash, _) in seen.iter() {
                    hash_map.insert(hash, 1);
                }
            } else {
                let mut temp_map = HashMap::new();
                for (&hash, _) in seen.iter() {
                    if hash_map.contains_key(&hash) {
                        temp_map.insert(hash, 1);
                    }
                }
                hash_map = temp_map;
                if hash_map.is_empty() {
                    return false;
                }
            }
        }

        !hash_map.is_empty()
    }
}
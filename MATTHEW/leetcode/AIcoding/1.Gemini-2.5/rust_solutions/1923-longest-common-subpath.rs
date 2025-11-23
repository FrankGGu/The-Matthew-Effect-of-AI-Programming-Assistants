use std::collections::{HashMap, HashSet};

const P1: u64 = 100003;
const M1: u64 = 1_000_000_007;
const P2: u64 = 10000019;
const M2: u64 = 1_000_000_009;

struct Solution;

impl Solution {
    pub fn longest_common_subpath(n_param: i32, paths: Vec<Vec<i32>>) -> i32 {
        let n = n_param as usize;

        let mut min_path_length = std::i32::MAX;
        for path in paths.iter() {
            min_path_length = min_path_length.min(path.len() as i32);
        }

        let mut low = 0;
        let mut high = min_path_length;
        let mut ans = 0;

        while low <= high {
            let mid = low + (high - low) / 2;
            if Self::check(mid, &paths, n) {
                ans = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        ans
    }

    fn check(k: i32, paths: &Vec<Vec<i32>>, n: usize) -> bool {
        if k == 0 {
            return true;
        }

        let k_usize = k as usize;

        let mut pow1 = 1;
        let mut pow2 = 1;
        for _ in 0..k_usize - 1 {
            pow1 = (pow1 * P1) % M1;
            pow2 = (pow2 * P2) % M2;
        }

        let mut counts: HashMap<(u64, u64), i32> = HashMap::new();

        for path in paths.iter() {
            if path.len() < k_usize {
                continue;
            }

            let mut path_unique_hashes: HashSet<(u64, u64)> = HashSet::new();
            let mut current_hash1 = 0;
            let mut current_hash2 = 0;

            for i in 0..k_usize {
                current_hash1 = (current_hash1 * P1 + path[i] as u64) % M1;
                current_hash2 = (current_hash2 * P2 + path[i] as u64) % M2;
            }
            path_unique_hashes.insert((current_hash1, current_hash2));

            for i in k_usize..path.len() {
                current_hash1 = (current_hash1 - (path[i - k_usize] as u64 * pow1) % M1 + M1) % M1;
                current_hash2 = (current_hash2 - (path[i - k_usize] as u64 * pow2) % M2 + M2) % M2;

                current_hash1 = (current_hash1 * P1 + path[i] as u64) % M1;
                current_hash2 = (current_hash2 * P2 + path[i] as u64) % M2;

                path_unique_hashes.insert((current_hash1, current_hash2));
            }

            for hash_pair in path_unique_hashes.into_iter() {
                *counts.entry(hash_pair).or_insert(0) += 1;
            }
        }

        for count in counts.values() {
            if *count == n as i32 {
                return true;
            }
        }

        false
    }
}
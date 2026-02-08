use std::collections::HashSet;

pub struct Solution;

impl Solution {
    pub fn longest_common_subpath(n: i32, paths: Vec<Vec<i32>>) -> i32 {
        let mut base = 1_000_000_007;
        let mut p = 1;
        let mut hashes = HashSet::new();

        for length in (1..=n as usize).rev() {
            hashes.clear();
            let mut hash = 0;
            for i in 0..length {
                hash = (hash * 1_000_000_007 + paths[0][i]) % base;
            }
            hashes.insert(hash);

            for i in 1..(paths[0].len() - length + 1) {
                hash = (hash * 1_000_000_007 + paths[0][i + length - 1]) % base;
                hash = (hash + base - (p * paths[0][i - 1]) % base) % base;
                hashes.insert(hash);
            }

            p = (p * 1_000_000_007) % base;

            if paths.iter().skip(1).all(|path| {
                let mut hash = 0;
                for i in 0..length {
                    hash = (hash * 1_000_000_007 + path[i]) % base;
                }
                if hashes.contains(&hash) {
                    return true;
                }
                for i in 1..(path.len() - length + 1) {
                    hash = (hash * 1_000_000_007 + path[i + length - 1]) % base;
                    hash = (hash + base - (p * path[i - 1]) % base) % base;
                    if hashes.contains(&hash) {
                        return true;
                    }
                }
                false
            }) {
                return length as i32;
            }
        }
        0
    }
}
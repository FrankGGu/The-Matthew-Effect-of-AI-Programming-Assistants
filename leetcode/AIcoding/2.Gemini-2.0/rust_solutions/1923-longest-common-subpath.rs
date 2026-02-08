impl Solution {
    pub fn longest_common_subpath(n: i32, paths: Vec<Vec<i32>>) -> i32 {
        let mut min_len = paths[0].len();
        for path in &paths {
            min_len = min_len.min(path.len());
        }

        let mut left = 0;
        let mut right = min_len as i32;

        while left <= right {
            let mid = left + (right - left) / 2;
            if Self::check(&paths, mid as usize, n as i64) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        right
    }

    fn check(paths: &Vec<Vec<i32>>, len: usize, n: i64) -> bool {
        if len == 0 {
            return true;
        }

        let base: i64 = 31;
        let modulo: i64 = 1000000007;

        let mut first_hashes = std::collections::HashSet::new();

        for i in 0..paths[0].len() - len + 1 {
            let mut hash: i64 = 0;
            let mut power: i64 = 1;

            for j in 0..len {
                hash = (hash * base + paths[0][i + j] as i64 + 1) % modulo;
                if j < len - 1 {
                    power = (power * base) % modulo;
                }
            }

            first_hashes.insert(hash);
        }

        for i in 1..paths.len() {
            let mut current_hashes = std::collections::HashSet::new();
            for j in 0..paths[i].len() - len + 1 {
                let mut hash: i64 = 0;
                let mut power: i64 = 1;

                for k in 0..len {
                    hash = (hash * base + paths[i][j + k] as i64 + 1) % modulo;
                    if k < len - 1 {
                        power = (power * base) % modulo;
                    }
                }
                if first_hashes.contains(&hash) {
                    current_hashes.insert(hash);
                }
            }
            first_hashes = current_hashes;
            if first_hashes.is_empty() {
                return false;
            }
        }

        true
    }
}
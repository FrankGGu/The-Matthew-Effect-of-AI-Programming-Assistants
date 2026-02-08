impl Solution {
    pub fn find_rotate_steps(ring: String, key: String) -> i32 {
        let ring: Vec<char> = ring.chars().collect();
        let key: Vec<char> = key.chars().collect();
        let n = ring.len();
        let m = key.len();
        let mut dp = vec![vec![std::i32::MAX; n]; m + 1];
        dp[0][0] = 0;

        for i in 0..m {
            for j in 0..n {
                if dp[i][j] == std::i32::MAX {
                    continue;
                }
                for k in 0..n {
                    if ring[k] == key[i] {
                        let diff = (j as i32 - k as i32).abs();
                        let step = diff.min(n as i32 - diff) + 1;
                        dp[i + 1][k] = dp[i + 1][k].min(dp[i][j] + step);
                    }
                }
            }
        }

        *dp[m].iter().min().unwrap()
    }
}
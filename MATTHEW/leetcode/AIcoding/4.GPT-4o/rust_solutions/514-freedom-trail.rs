impl Solution {
    pub fn find_rotate_steps(ring: String, key: String) -> i32 {
        let ring: Vec<char> = ring.chars().collect();
        let key: Vec<char> = key.chars().collect();
        let n = ring.len();
        let m = key.len();

        let mut dp = vec![vec![i32::MAX; n]; m + 1];
        dp[0].iter_mut().for_each(|x| *x = 0);

        for i in 1..=m {
            for j in 0..n {
                for k in 0..n {
                    if ring[j] == key[i - 1] {
                        let distance = ((j as i32 - k as i32).abs().min((n as i32 - (j as i32 - k as i32).abs()))) + 1);
                        dp[i][j] = dp[i][j].min(dp[i - 1][k] + distance);
                    }
                }
            }
        }

        dp[m].iter().cloned().min().unwrap()
    }
}
impl Solution {
    pub fn num_rolls_to_target(d: i32, f: i32, target: i32) -> i32 {
        let mod_value = 1_000_000_007;
        let mut dp = vec![vec![0; target as usize + 1]; (d + 1) as usize];
        dp[0][0] = 1;

        for i in 1..=d {
            for j in 1..=target {
                for k in 1..=f {
                    if j >= k {
                        dp[i as usize][j as usize] = (dp[i as usize][j as usize] + dp[(i - 1) as usize][(j - k) as usize]) % mod_value;
                    }
                }
            }
        }

        dp[d as usize][target as usize]
    }
}
impl Solution {
    pub fn tallest_billboard(rods: Vec<i32>) -> i32 {
        let mut dp = vec![std::i32::MIN; 10001];
        dp[0] = 0;

        for &rod in &rods {
            let mut new_dp = dp.clone();
            for j in (0..=10000).rev() {
                if dp[j] >= 0 {
                    new_dp[j + rod as usize] = new_dp[j + rod as usize].max(dp[j]);
                    if j >= rod as usize {
                        new_dp[j - rod as usize] = new_dp[j - rod as usize].max(dp[j] + rod);
                    }
                }
            }
            dp = new_dp;
        }

        dp[0]
    }
}
impl Solution {
    pub fn min_increments(n: i32, cost: Vec<i32>, target: i32) -> i32 {
        let mut dp = vec![0; target as usize + 1];

        for &c in &cost {
            for j in (c..=target).rev() {
                dp[j as usize] = dp[j as usize].max(dp[(j - c) as usize] + c);
            }
        }

        dp[target as usize]
    }
}
impl Solution {
    pub fn largest_sum_of_averages(nums: Vec<i32>, k: i32) -> f64 {
        let n = nums.len();
        let k = k as usize;
        let mut prefix_sum = vec![0.0; n + 1];
        for i in 0..n {
            prefix_sum[i + 1] = prefix_sum[i] + nums[i] as f64;
        }

        let mut dp = vec![vec![0.0; n + 1]; k + 1];

        for i in 1..=n {
            dp[1][i] = prefix_sum[i] / i as f64;
        }

        for i in 2..=k {
            for j in i..=n {
                for x in (i - 1)..j {
                    dp[i][j] = dp[i][j].max(dp[i - 1][x] + (prefix_sum[j] - prefix_sum[x]) / (j - x) as f64);
                }
            }
        }

        dp[k][n]
    }
}
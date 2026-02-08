pub fn max_sum(nums: Vec<i32>, multipliers: Vec<i32>) -> i32 {
    let n = nums.len();
    let m = multipliers.len();
    let mut dp = vec![vec![0; m + 1]; m + 1];

    for i in 1..=m {
        for j in 0..=i {
            let k = i - j;
            if j > 0 {
                dp[j][i] = dp[j][i].max(dp[j - 1][i - 1] + nums[j - 1] * multipliers[i - 1]);
            }
            if k > 0 {
                dp[j][i] = dp[j][i].max(dp[j][i - 1] + nums[n - k] * multipliers[i - 1]);
            }
        }
    }

    *dp[m].iter().max().unwrap()
}
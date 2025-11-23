impl Solution {
    pub fn largest_sum_of_averages(nums: Vec<i32>, k: i32) -> f64 {
        let n = nums.len();
        let k = k as usize;

        let mut prefix_sum = vec![0; n + 1];
        for i in 0..n {
            prefix_sum[i + 1] = prefix_sum[i] + nums[i];
        }

        let mut dp = vec![vec![0.0; k + 1]; n + 1];

        // Base case: k = 1
        for i in 1..=n {
            dp[i][1] = prefix_sum[i] as f64 / i as f64;
        }

        // Fill dp table for k from 2 to K
        for k_val in 2..=k {
            for i in k_val..=n { // i represents the number of elements considered (nums[0]...nums[i-1])
                for j in (k_val - 1)..i { // j is the split point: nums[0]...nums[j-1] for k_val-1 groups, nums[j]...nums[i-1] for the k_val-th group
                    let current_sum = prefix_sum[i] - prefix_sum[j];
                    let count = (i - j) as f64;
                    let current_avg = current_sum as f64 / count;
                    dp[i][k_val] = dp[i][k_val].max(dp[j][k_val - 1] + current_avg);
                }
            }
        }

        dp[n][k]
    }
}
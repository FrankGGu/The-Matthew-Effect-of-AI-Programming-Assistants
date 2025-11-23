impl Solution {
    pub fn min_space_wasted_k_resizing(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let k = k as usize;
        let mut dp = vec![vec![i32::MAX; k + 2]; n + 1];
        let mut prefix_sum = vec![0; n + 1];
        for i in 1..=n {
            prefix_sum[i] = prefix_sum[i - 1] + nums[i - 1];
        }

        dp[0][0] = 0;

        for i in 1..=n {
            for j in 0..=k + 1 {
                for l in 1..=i {
                    let max_val = nums[l - 1..i].iter().max().unwrap();
                    let wasted = max_val * (i - l + 1) as i32 - (prefix_sum[i] - prefix_sum[l - 1]);
                    if j > 0 && dp[l - 1][j - 1] != i32::MAX {
                        dp[i][j] = dp[i][j].min(dp[l - 1][j - 1] + wasted);
                    }
                }
            }
        }

        dp[n][k + 1]
    }
}
pub fn min_pair_removals(nums: Vec<i32>) -> i32 {
    let mut nums = nums;
    nums.sort();
    let n = nums.len();
    let mut dp = vec![0; n];
    let mut max_len = 0;

    for i in (0..n).rev() {
        dp[i] = 1;
        for j in (i + 1)..n {
            if (nums[j] - nums[i]).abs() <= 2 {
                dp[i] = dp[i].max(dp[j] + 1);
            }
        }
        max_len = max_len.max(dp[i]);
    }

    n - max_len
}
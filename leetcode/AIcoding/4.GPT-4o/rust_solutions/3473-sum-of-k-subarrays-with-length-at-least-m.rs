pub fn sum_of_k_subarrays(nums: Vec<i32>, k: i32, m: i32) -> i32 {
    let n = nums.len();
    let mut max_sum = vec![0; n + 1];
    let mut current_sum = 0;

    for i in 0..n {
        current_sum += nums[i];
        if i >= m as usize {
            current_sum -= nums[i - m as usize];
        }
        max_sum[i + 1] = max_sum[i].max(current_sum);
    }

    let mut max_total = 0;
    let mut dp = vec![0; n + 1];

    for i in m as usize..=n {
        dp[i] = dp[i - 1].max(max_sum[i - m as usize]) + nums[i - 1];
        max_total = max_total.max(dp[i]);
    }

    max_total
}
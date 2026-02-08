pub fn max_sum_div_k(nums: Vec<i32>, k: usize) -> i32 {
    let n = nums.len();
    let mut dp = vec![std::i32::MIN; k];
    dp[0] = 0;
    let mut sum = 0;
    let mut result = std::i32::MIN;

    for i in 0..n {
        sum += nums[i];
        let current = dp.clone();
        for j in 0..k {
            let index = (j + 1) % k;
            current[index] = current[index].max(dp[j] + nums[i]);
        }
        dp = current;
        if i + 1 >= k {
            result = result.max(dp[0]);
        }
    }

    result
}
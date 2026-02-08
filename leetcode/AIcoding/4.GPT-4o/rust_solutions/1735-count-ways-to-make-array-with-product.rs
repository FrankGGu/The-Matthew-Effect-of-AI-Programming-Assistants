use std::collections::HashMap;

pub fn count_ways_to_make_array_with_product(nums: Vec<i32>, target: i32) -> i32 {
    const MOD: i32 = 1_000_000_007;
    let n = nums.len();
    let mut dp = vec![0; target as usize + 1];
    dp[1] = 1;

    for &num in &nums {
        for j in (num..=target).rev() {
            dp[j as usize] = (dp[j as usize] + dp[(j / num) as usize]) % MOD;
        }
    }
    dp[target as usize]
}
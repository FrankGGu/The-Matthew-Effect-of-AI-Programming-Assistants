pub fn count_subsets_with_bounded_sum(nums: Vec<i32>, limit: i32) -> i32 {
    let n = nums.len();
    let mut dp = vec![0; (limit + 1) as usize];
    dp[0] = 1;

    for &num in &nums {
        for j in (num..=limit).rev() {
            dp[j as usize] += dp[(j - num) as usize];
        }
    }

    dp.iter().sum()
}
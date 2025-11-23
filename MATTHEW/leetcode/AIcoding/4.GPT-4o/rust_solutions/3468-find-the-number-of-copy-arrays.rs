pub fn count_copy_arrays(nums: Vec<i32>) -> i32 {
    let n = nums.len();
    let mut dp = vec![0; n];
    let mut count = 0;

    for i in (0..n).rev() {
        dp[i] = 1;
        for j in (i + 1)..n {
            if nums[j] >= nums[i] {
                dp[i] += dp[j];
            }
        }
        count += dp[i];
    }

    count as i32
}
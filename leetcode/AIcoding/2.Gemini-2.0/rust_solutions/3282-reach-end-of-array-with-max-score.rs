impl Solution {
    pub fn max_score(nums: Vec<i32>, x: i32) -> i64 {
        let n = nums.len();
        let mut dp = vec![0i64; n];
        dp[0] = nums[0] as i64;
        let mut odd_count = 0;
        let mut even_count = 0;
        if nums[0] % 2 == 0 {
            even_count += 1;
        } else {
            odd_count += 1;
        }
        for i in 1..n {
            if nums[i] % 2 == 0 {
                dp[i] = dp[i - 1] + nums[i] as i64;
                if nums[i - 1] % 2 != 0 {
                    dp[i] -= x as i64;
                }
            } else {
                dp[i] = dp[i - 1] + nums[i] as i64;
                if nums[i - 1] % 2 == 0 {
                    dp[i] -= x as i64;
                }
            }

        }

        dp[n - 1]
    }
}
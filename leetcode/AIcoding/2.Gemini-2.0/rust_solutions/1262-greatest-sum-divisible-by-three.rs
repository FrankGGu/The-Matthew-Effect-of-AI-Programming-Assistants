impl Solution {
    pub fn max_sum_divisible_by3(nums: Vec<i32>) -> i32 {
        let mut dp = [0, i32::MIN, i32::MIN];
        for &num in &nums {
            let rem = (num % 3) as usize;
            let new_dp = match rem {
                0 => [
                    dp[0] + num,
                    dp[1] + num,
                    dp[2] + num
                ],
                1 => [
                    dp[2],
                    dp[0],
                    dp[1]
                ],
                2 => [
                    dp[1],
                    dp[2],
                    dp[0]
                ],
                _ => unreachable!()
            };
            dp[0] = dp[0].max(new_dp[0] + if rem == 0 {0} else {0});
            dp[1] = dp[1].max(new_dp[1] + num);
            dp[2] = dp[2].max(new_dp[2] + num);
        }
        dp[0]
    }
}
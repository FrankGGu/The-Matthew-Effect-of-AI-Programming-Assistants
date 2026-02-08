impl Solution {
    pub fn max_sum_div_three(nums: Vec<i32>) -> i32 {
        let mut dp = [0, std::i32::MIN, std::i32::MIN];
        for num in nums {
            let mut new_dp = dp.clone();
            for i in 0..3 {
                let rem = (i + num as usize) % 3;
                new_dp[rem] = new_dp[rem].max(dp[i] + num);
            }
            dp = new_dp;
        }
        dp[0]
    }
}
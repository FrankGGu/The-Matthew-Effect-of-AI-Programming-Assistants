impl Solution {
    pub fn max_sum_div_by_three(nums: Vec<i32>) -> i32 {
        let mut dp = vec![0, i32::MIN, i32::MIN];

        for num in nums {
            let mut new_dp = dp.clone();

            for rem in 0..3 {
                if dp[rem] == i32::MIN {
                    continue;
                }

                let new_rem = (rem + num as usize) % 3;
                new_dp[new_rem] = new_dp[new_rem].max(dp[rem] + num);
            }
            dp = new_dp;
        }

        dp[0]
    }
}
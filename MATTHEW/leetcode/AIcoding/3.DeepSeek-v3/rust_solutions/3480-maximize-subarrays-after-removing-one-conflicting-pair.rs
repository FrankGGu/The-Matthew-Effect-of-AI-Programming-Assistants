impl Solution {
    pub fn maximum_sum_subarrays_after_operation(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n == 0 {
            return 0;
        }

        let mut dp = vec![vec![0; 2]; n];
        dp[0][0] = nums[0];
        dp[0][1] = nums[0] * nums[0];
        let mut max_sum = dp[0][1];

        for i in 1..n {
            let num = nums[i];
            let squared = num * num;

            dp[i][0] = num.max(dp[i-1][0] + num);
            dp[i][1] = (squared.max(dp[i-1][1] + num)).max(dp[i-1][0] + squared);

            max_sum = max_sum.max(dp[i][1]);
        }

        max_sum
    }
}
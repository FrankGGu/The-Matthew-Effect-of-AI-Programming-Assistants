impl Solution {
    pub fn max_coins(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut balloons = vec![1];
        balloons.extend(nums);
        balloons.push(1);
        let n = n + 2;

        let mut dp = vec![vec![0; n]; n];

        for length in 1..n-1 {
            for left in 1..n-length {
                let right = left + length - 1;
                for k in left..=right {
                    dp[left][right] = dp[left][right].max(dp[left][k-1] + dp[k+1][right] + balloons[left-1] * balloons[k] * balloons[right+1]);
                }
            }
        }

        dp[1][n-2]
    }
}
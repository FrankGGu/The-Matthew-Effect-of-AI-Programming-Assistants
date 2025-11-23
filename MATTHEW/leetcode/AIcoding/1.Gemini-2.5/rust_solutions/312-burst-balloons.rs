impl Solution {
    pub fn max_coins(nums: Vec<i32>) -> i32 {
        let n = nums.len();

        let mut points = Vec::with_capacity(n + 2);
        points.push(1);
        points.extend_from_slice(&nums);
        points.push(1);

        let m = points.len();
        let mut dp = vec![vec![0; m]; m];

        for len in 2..m {
            for i in 0..(m - len) {
                let j = i + len;
                for k in (i + 1)..j {
                    let current_coins = points[i] * points[k] * points[j];
                    dp[i][j] = dp[i][j].max(dp[i][k] + dp[k][j] + current_coins);
                }
            }
        }

        dp[0][m - 1]
    }
}
impl Solution {
    pub fn min_operation_cost(operators: Vec<i32>, target: i32) -> i32 {
        let n = operators.len();
        let mut dp = vec![vec![i32::MAX / 2; target as usize + 1]; n + 1];
        dp[0][0] = 0;

        for i in 1..=n {
            for j in 0..=target {
                dp[i][j] = dp[i - 1][j];
                if j >= operators[i - 1] {
                    dp[i][j] = dp[i][j].min(dp[i][j - operators[i - 1]] + operators[i - 1]);
                }
            }
        }

        if dp[n][target] == i32::MAX / 2 {
            -1
        } else {
            dp[n][target]
        }
    }
}
impl Solution {
    pub fn maximum_height(triangle: Vec<Vec<i32>>) -> i32 {
        let n = triangle.len();
        let mut dp = triangle[n - 1].clone();

        for i in (0..n - 1).rev() {
            for j in 0..=i {
                dp[j] = triangle[i][j] + dp[j].max(dp[j + 1]);
            }
        }

        dp[0]
    }
}
impl Solution {
    pub fn comfortable_humidity(humidity: Vec<i32>) -> i32 {
        let n = humidity.len();
        let mut dp = vec![vec![0; n]; n];

        for i in 0..n {
            dp[i][i] = humidity[i];
        }

        for len in 2..=n {
            for i in 0..=n-len {
                let j = i + len - 1;
                dp[i][j] = (humidity[i] - dp[i+1][j]).max(humidity[j] - dp[i][j-1]);
            }
        }

        dp[0][n-1]
    }
}
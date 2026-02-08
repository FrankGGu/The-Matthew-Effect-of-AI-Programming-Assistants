impl Solution {
    pub fn most_points(questions: Vec<Vec<i32>>) -> i64 {
        let n = questions.len();
        let mut dp = vec![0; n + 1];

        for i in (0..n).rev() {
            let points = questions[i][0] as i64;
            let brainpower = questions[i][1] as usize;

            let next_index = i + brainpower + 1;

            if next_index > n {
                dp[i] = points;
            } else {
                dp[i] = points + dp[next_index];
            }

            dp[i] = dp[i].max(dp[i + 1]);
        }

        dp[0]
    }
}
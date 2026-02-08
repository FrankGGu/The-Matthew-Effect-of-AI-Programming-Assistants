impl Solution {
    pub fn most_points(questions: Vec<Vec<i32>>) -> i64 {
        let n = questions.len();
        let mut dp = vec![0; n + 1];

        for i in (0..n).rev() {
            let points = questions[i][0];
            let brainpower = questions[i][1] as usize;
            dp[i] = dp[i + 1].max(points + if i + brainpower + 1 <= n { dp[i + brainpower + 1] } else { 0 });
        }

        dp[0]
    }
}
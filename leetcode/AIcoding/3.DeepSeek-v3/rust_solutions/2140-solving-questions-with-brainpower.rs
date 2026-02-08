impl Solution {
    pub fn most_points(questions: Vec<Vec<i32>>) -> i64 {
        let n = questions.len();
        let mut dp = vec![0i64; n + 1];
        for i in (0..n).rev() {
            let (points, brainpower) = (questions[i][0] as i64, questions[i][1] as usize);
            let next = if i + brainpower + 1 < n { dp[i + brainpower + 1] } else { 0 };
            dp[i] = std::cmp::max(dp[i + 1], points + next);
        }
        dp[0]
    }
}
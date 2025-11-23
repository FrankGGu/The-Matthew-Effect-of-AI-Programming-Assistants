impl Solution {
    pub fn most_points(questions: Vec<Vec<i32>>) -> i64 {
        let n = questions.len();
        let mut dp: Vec<i64> = vec![0; n + 1];

        for i in (0..n).rev() {
            let points = questions[i][0] as i64;
            let brainpower = questions[i][1] as usize;

            let skip_current = dp[i + 1];

            let solve_current_next_idx = (i + 1 + brainpower).min(n);
            let solve_current = points + dp[solve_current_next_idx];

            dp[i] = skip_current.max(solve_current);
        }

        dp[0]
    }
}
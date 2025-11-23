impl Solution {

use std::cmp::max;

impl Solution {
    pub fn most_questions(questions: Vec<Vec<i32>>) -> i32 {
        let n = questions.len();
        let mut dp = vec![0; n];

        for i in (0..n).rev() {
            let take = questions[i][0] + if i + questions[i][1] as usize < n { dp[i + questions[i][1] as usize] } else { 0 };
            let not_take = dp[i + 1];
            dp[i] = max(take, not_take);
        }

        dp[0]
    }
}
}
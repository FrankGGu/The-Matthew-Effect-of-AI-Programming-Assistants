impl Solution {
    pub fn best_team_score(scores: Vec<i32>, ages: Vec<i32>) -> i32 {
        let n = scores.len();
        let mut players: Vec<(i32, i32)> = ages.into_iter().zip(scores.into_iter()).collect();
        players.sort();

        let mut dp = vec![0; n];
        let mut max_score = 0;

        for i in 0..n {
            dp[i] = players[i].1;
            for j in 0..i {
                if players[j].1 <= players[i].1 {
                    dp[i] = dp[i].max(dp[j] + players[i].1);
                }
            }
            max_score = max_score.max(dp[i]);
        }

        max_score
    }
}
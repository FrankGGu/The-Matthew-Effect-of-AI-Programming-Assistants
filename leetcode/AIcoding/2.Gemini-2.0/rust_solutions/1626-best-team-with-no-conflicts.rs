impl Solution {
    pub fn best_team_score(scores: Vec<i32>, ages: Vec<i32>) -> i32 {
        let n = scores.len();
        let mut players: Vec<(i32, i32)> = scores.into_iter().zip(ages.into_iter()).collect();
        players.sort_unstable();

        let mut dp = vec![0; n];
        let mut max_score = 0;

        for i in 0..n {
            dp[i] = players[i].0;
            for j in 0..i {
                if players[i].1 >= players[j].1 {
                    dp[i] = dp[i].max(dp[j] + players[i].0);
                }
            }
            max_score = max_score.max(dp[i]);
        }

        max_score
    }
}
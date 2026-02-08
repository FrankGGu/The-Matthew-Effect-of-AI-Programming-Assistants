impl Solution {
    pub fn best_team_score(scores: Vec<i32>, ages: Vec<i32>) -> i32 {
        let mut players: Vec<(i32, i32)> = scores.into_iter().zip(ages).collect();
        players.sort_by(|a, b| if a.1 == b.1 { a.0.cmp(&b.0) } else { a.1.cmp(&b.1) });

        let n = players.len();
        let mut dp = vec![0; n];

        for i in 0..n {
            dp[i] = players[i].0;
            for j in 0..i {
                if players[j].0 <= players[i].0 {
                    dp[i] = dp[i].max(dp[j] + players[i].0);
                }
            }
        }

        *dp.iter().max().unwrap()
    }
}
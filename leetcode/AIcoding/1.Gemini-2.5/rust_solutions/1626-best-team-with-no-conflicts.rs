impl Solution {
    pub fn best_team_score(scores: Vec<i32>, ages: Vec<i32>) -> i32 {
        let n = scores.len();
        let mut players: Vec<(i32, i32)> = (0..n).map(|i| (scores[i], ages[i])).collect();

        players.sort_unstable_by(|a, b| {
            if a.0 != b.0 {
                // Sort by score in descending order
                b.0.cmp(&a.0)
            } else {
                // If scores are equal, sort by age in descending order
                b.1.cmp(&a.1)
            }
        });

        let mut dp = vec![0; n];
        let mut max_total_score = 0;

        for i in 0..n {
            // Initialize dp[i] with the current player's score (forming a team of one)
            dp[i] = players[i].0;

            // Iterate through previous players (j < i)
            for j in 0..i {
                // Condition for including players[j] before players[i] in a team:
                // 1. players[j].score >= players[i].score is guaranteed by the primary sort order (score descending).
                // 2. The conflict rule: "An older player cannot have a strictly lower score than a younger player."
                //    Let P_j = (score_j, age_j) and P_i = (score_i, age_i).
                //    We know score_j >= score_i.
                //    If age_j > age_i (P_j is older than P_i): Conflict if score_j < score_i.
                //       This is impossible because score_j >= score_i. So, no conflict.
                //    If age_j < age_i (P_i is older than P_j): Conflict if score_i < score_j.
                //       This is possible and would be a conflict. So, we must avoid this case.
                //    If age_j == age_i (P_j and P_i are same age): No age-based conflict.
                //
                // Therefore, players[j] and players[i] are compatible if age_j >= age_i.
                if players[j].1 >= players[i].1 {
                    dp[i] = dp[i].max(dp[j] + players[i].0);
                }
            }
            max_total_score = max_total_score.max(dp[i]);
        }

        max_total_score
    }
}
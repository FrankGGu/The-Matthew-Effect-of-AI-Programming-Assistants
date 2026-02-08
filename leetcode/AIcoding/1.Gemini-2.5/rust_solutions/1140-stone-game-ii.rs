use std::cmp::max;

impl Solution {
    pub fn stone_game_ii(piles: Vec<i32>) -> i32 {
        let n = piles.len();

        let mut suffix_sum = vec![0; n + 1];
        for i in (0..n).rev() {
            suffix_sum[i] = piles[i] + suffix_sum[i + 1];
        }

        // dp[i][m] represents the maximum number of stones the current player can get
        // if the game starts from pile 'i' and the current 'M' value is 'm'.
        // i ranges from 0 to n (n means no piles left)
        // m ranges from 1 to n (M is capped at n because if M >= n, 2M >= 2n,
        // which means the player can take all remaining piles regardless of 'i')
        let mut dp = vec![vec![0; n + 1]; n + 1];

        // Iterate 'i' from 'n-1' down to '0' (bottom-up DP for piles)
        for i in (0..n).rev() {
            // Iterate 'm' from 'n' down to '1' (bottom-up DP for M, as dp[i][m] can depend on dp[i+x][max(m,x)])
            for m_val in (1..=n).rev() {
                let mut max_stones_for_current_player = 0;

                // The current player can take 'x' piles, where 1 <= x <= 2*m_val
                for x in 1..=(2 * m_val) {
                    // If taking 'x' piles goes beyond the end of the array, break
                    if i + x > n {
                        break;
                    }

                    // The next M value will be max(m_val, x), capped at n
                    let next_m_val = max(m_val, x).min(n);

                    // The next player's maximum score if the game starts from piles[i+x] with M = next_m_val
                    let next_player_max_score = dp[i + x][next_m_val];

                    // The current player's total score for this choice:
                    // (stones taken this turn) + (stones remaining after next player plays from i+x)
                    // Stones taken this turn: suffix_sum[i] - suffix_sum[i+x]
                    // Stones remaining after next player plays: suffix_sum[i+x] - next_player_max_score
                    // Total: (suffix_sum[i] - suffix_sum[i+x]) + (suffix_sum[i+x] - next_player_max_score)
                    // Which simplifies to: suffix_sum[i] - next_player_max_score
                    let current_player_total_score = suffix_sum[i] - next_player_max_score;

                    max_stones_for_current_player = max(max_stones_for_current_player, current_player_total_score);
                }
                dp[i][m_val] = max_stones_for_current_player;
            }
        }

        // The game starts at pile 0 with M=1
        dp[0][1]
    }
}
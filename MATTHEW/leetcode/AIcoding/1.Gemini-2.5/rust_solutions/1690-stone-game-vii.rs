impl Solution {
    pub fn stone_game_vii(stones: Vec<i32>) -> i32 {
        let n = stones.len();

        let mut prefix_sum = vec![0; n + 1];
        for i in 0..n {
            prefix_sum[i + 1] = prefix_sum[i] + stones[i];
        }

        let mut dp = vec![vec![0; n]; n];

        for len in 2..=n {
            for i in 0..=(n - len) {
                let j = i + len - 1;

                // Option 1: Current player removes stones[i]
                // Score gained by current player: sum of stones[i+1..=j]
                // This sum is prefix_sum[j+1] - prefix_sum[i+1]
                let score_if_remove_i = prefix_sum[j + 1] - prefix_sum[i + 1];
                // The opponent then plays on stones[i+1..=j] and will achieve dp[i+1][j] score difference.
                // This means (opponent's score from remaining) - (current player's score from remaining) = dp[i+1][j].
                // So, (current player's score from remaining) - (opponent's score from remaining) = -dp[i+1][j].
                let diff_if_remove_i = score_if_remove_i - dp[i + 1][j];

                // Option 2: Current player removes stones[j]
                // Score gained by current player: sum of stones[i..=j-1]
                // This sum is prefix_sum[j] - prefix_sum[i]
                let score_if_remove_j = prefix_sum[j] - prefix_sum[i];
                // The opponent then plays on stones[i..=j-1] and will achieve dp[i][j-1] score difference.
                // Similar to above, current player's score difference from remaining is -dp[i][j-1].
                let diff_if_remove_j = score_if_remove_j - dp[i][j - 1];

                dp[i][j] = std::cmp::max(diff_if_remove_i, diff_if_remove_j);
            }
        }

        dp[0][n - 1]
    }
}
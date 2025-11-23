use std::cmp::max;

impl Solution {
    pub fn stone_game_iii(stone_value: Vec<i32>) -> String {
        let n = stone_value.len();
        // dp[i] stores the maximum score Alice can get minus Bob's score
        // when the game starts from stoneValue[i:].
        // The dp array is sized n+3 to safely handle accesses like dp[i+1], dp[i+2], dp[i+3]
        // when i is near the end of the array. Indices beyond n-1 (i.e., n, n+1, n+2)
        // represent the state where no stones are left, thus the score difference is 0.
        let mut dp = vec![0; n + 3];

        // Iterate from the end of the stoneValue array backwards
        for i in (0..n).rev() {
            let mut max_score_diff = i32::MIN;

            // Option 1: Alice takes 1 stone
            // Her score is stoneValue[i]. Bob's turn starts from i+1.
            // Bob will play optimally to maximize his score, which means minimizing Alice's score
            // relative to his. So, the resulting score difference for Alice is
            // (Alice's current stones) - (Bob's optimal score difference from i+1, which is dp[i+1]).
            let sum_1 = stone_value[i];
            max_score_diff = max(max_score_diff, sum_1 - dp[i + 1]);

            // Option 2: Alice takes 2 stones
            // This option is only available if there are at least 2 stones remaining.
            if i + 1 < n {
                let sum_2 = stone_value[i] + stone_value[i + 1];
                max_score_diff = max(max_score_diff, sum_2 - dp[i + 2]);
            }

            // Option 3: Alice takes 3 stones
            // This option is only available if there are at least 3 stones remaining.
            if i + 2 < n {
                let sum_3 = stone_value[i] + stone_value[i + 1] + stone_value[i + 2];
                max_score_diff = max(max_score_diff, sum_3 - dp[i + 3]);
            }

            dp[i] = max_score_diff;
        }

        // dp[0] contains the final score difference (Alice's total score - Bob's total score)
        if dp[0] > 0 {
            "Alice".to_string()
        } else if dp[0] < 0 {
            "Bob".to_string()
        } else {
            "Tie".to_string()
        }
    }
}
impl Solution {
    pub fn stone_game_v(stone_value: Vec<i32>) -> i32 {
        let n = stone_value.len();

        let mut prefix_sum = vec![0; n + 1];
        for i in 0..n {
            prefix_sum[i + 1] = prefix_sum[i] + stone_value[i];
        }

        let mut dp = vec![vec![0; n]; n];
        let mut min_val = vec![vec![0; n]; n];

        for len in 2..=n {
            for i in 0..=n - len {
                let j = i + len - 1;

                let mut current_max_alice_score = 0;
                let mut current_min_alice_score_for_bob = i32::MAX;

                for k in i..j {
                    let left_sum = prefix_sum[k + 1] - prefix_sum[i];
                    let right_sum = prefix_sum[j + 1] - prefix_sum[k + 1];

                    // Alice's turn:
                    // Option 1: Alice takes left_sum, Bob plays on right segment [k+1..j]
                    let score_if_take_left = left_sum + min_val[k + 1][j];
                    // Option 2: Alice takes right_sum, Bob plays on left segment [i..k]
                    let score_if_take_right = right_sum + min_val[i][k];

                    current_max_alice_score = current_max_alice_score.max(score_if_take_left);
                    current_max_alice_score = current_max_alice_score.max(score_if_take_right);

                    // Bob's turn:
                    // Bob wants to minimize Alice's score.
                    // Option 1: Bob takes left_sum, Alice plays on right segment [k+1..j]
                    // Alice will get dp[k+1][j] from this subgame.
                    let bob_choice_1_alice_score = dp[k + 1][j];
                    // Option 2: Bob takes right_sum, Alice plays on left segment [i..k]
                    // Alice will get dp[i][k] from this subgame.
                    let bob_choice_2_alice_score = dp[i][k];

                    current_min_alice_score_for_bob = current_min_alice_score_for_bob
                        .min(bob_choice_1_alice_score)
                        .min(bob_choice_2_alice_score);
                }
                dp[i][j] = current_max_alice_score;
                min_val[i][j] = current_min_alice_score_for_bob;
            }
        }

        dp[0][n - 1]
    }
}
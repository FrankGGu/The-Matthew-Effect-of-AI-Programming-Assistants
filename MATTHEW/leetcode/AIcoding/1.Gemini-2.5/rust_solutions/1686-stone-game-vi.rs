struct Solution;

impl Solution {
    pub fn stone_game_vi(alice_values: Vec<i32>, bob_values: Vec<i32>) -> bool {
        let n = alice_values.len();
        let mut stones: Vec<(i32, i32, i32)> = Vec::with_capacity(n);

        for i in 0..n {
            // Store (sum_of_values, alice_value, bob_value) for each stone
            stones.push((alice_values[i] + bob_values[i], alice_values[i], bob_values[i]));
        }

        // Sort stones in descending order based on the sum of values.
        // This greedy strategy ensures that players prioritize stones that offer the highest combined value,
        // effectively denying the opponent a potentially high-value stone.
        stones.sort_unstable_by(|a, b| b.0.cmp(&a.0));

        let mut alice_score = 0;
        let mut bob_score = 0;

        for (i, stone) in stones.iter().enumerate() {
            if i % 2 == 0 {
                // Alice's turn (0-indexed, so 0, 2, 4...)
                // Alice takes the stone, adding her value to her score.
                alice_score += stone.1; // stone.1 is alice_value
            } else {
                // Bob's turn (0-indexed, so 1, 3, 5...)
                // Bob takes the stone, adding his value to his score.
                bob_score += stone.2; // stone.2 is bob_value
            }
        }

        // Alice wins if her score is strictly greater than Bob's score.
        alice_score > bob_score
    }
}
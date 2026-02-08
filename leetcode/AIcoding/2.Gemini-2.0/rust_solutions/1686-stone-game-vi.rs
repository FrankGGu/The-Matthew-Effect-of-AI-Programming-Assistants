impl Solution {
    pub fn stone_game_vi(alice_values: Vec<i32>, bob_values: Vec<i32>) -> i32 {
        let n = alice_values.len();
        let mut stones: Vec<(i32, usize)> = (0..n).map(|i| (alice_values[i] + bob_values[i], i)).collect();
        stones.sort_by(|a, b| b.0.cmp(&a.0));

        let mut alice_score = 0;
        let mut bob_score = 0;

        for (i, &(sum, idx)) in stones.iter().enumerate() {
            if i % 2 == 0 {
                alice_score += alice_values[idx];
            } else {
                bob_score += bob_values[idx];
            }
        }

        if alice_score > bob_score {
            1
        } else if alice_score < bob_score {
            -1
        } else {
            0
        }
    }
}
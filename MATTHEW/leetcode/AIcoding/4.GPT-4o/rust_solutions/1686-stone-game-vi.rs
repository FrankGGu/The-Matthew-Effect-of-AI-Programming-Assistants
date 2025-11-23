impl Solution {
    pub fn stone_game_vi(alice_values: Vec<i32>, bob_values: Vec<i32>) -> i32 {
        let n = alice_values.len();
        let mut values: Vec<(i32, i32, usize)> = Vec::with_capacity(n);

        for i in 0..n {
            values.push((alice_values[i], bob_values[i], i));
        }

        values.sort_by(|a, b| (b.0 + b.1).cmp(&(a.0 + a.1)));

        let mut alice_score = 0;
        let mut bob_score = 0;

        for i in 0..n {
            if i % 2 == 0 {
                alice_score += values[i].0;
            } else {
                bob_score += values[i].1;
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
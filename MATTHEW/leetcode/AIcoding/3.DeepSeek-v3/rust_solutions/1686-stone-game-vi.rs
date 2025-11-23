use std::collections::BinaryHeap;

impl Solution {
    pub fn stone_game_vi(alice_values: Vec<i32>, bob_values: Vec<i32>) -> i32 {
        let n = alice_values.len();
        let mut heap = BinaryHeap::new();
        for i in 0..n {
            heap.push((alice_values[i] + bob_values[i], alice_values[i], bob_values[i]));
        }
        let mut alice_turn = true;
        let mut alice_score = 0;
        let mut bob_score = 0;
        while let Some((_, a, b)) = heap.pop() {
            if alice_turn {
                alice_score += a;
            } else {
                bob_score += b;
            }
            alice_turn = !alice_turn;
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
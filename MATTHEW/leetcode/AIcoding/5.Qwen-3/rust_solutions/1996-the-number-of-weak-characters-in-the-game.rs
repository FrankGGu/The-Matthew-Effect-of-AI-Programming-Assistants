impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn number_of_weak_characters(mut players: Vec<Vec<i32>>) -> i32 {
        players.sort_by(|a, b| {
            if a[0] == b[0] {
                b[1].cmp(&a[1])
            } else {
                b[0].cmp(&a[0])
            }
        });

        let mut weak = 0;
        let mut max_defense = 0;

        for player in players {
            if player[1] < max_defense {
                weak += 1;
            } else {
                max_defense = player[1];
            }
        }

        weak
    }
}
}
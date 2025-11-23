impl Solution {

use std::cmp::Ordering;

struct Solution;

impl Solution {
    pub fn match_players_with_trainers(mut players: Vec<i32>, mut trainers: Vec<i32>) -> i32 {
        players.sort_unstable();
        trainers.sort_unstable();

        let mut i = 0;
        let mut j = 0;
        let mut count = 0;

        while i < players.len() && j < trainers.len() {
            match players[i].cmp(&trainers[j]) {
                Ordering::Less => i += 1,
                Ordering::Equal | Ordering::Greater => {
                    count += 1;
                    i += 1;
                    j += 1;
                }
            }
        }

        count as i32
    }
}
}
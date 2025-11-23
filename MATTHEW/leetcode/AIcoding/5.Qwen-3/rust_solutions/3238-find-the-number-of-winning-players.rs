impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn winning_players(mut matches: Vec<Vec<i32>>) -> Vec<i32> {
        let mut score = HashMap::new();
        let mut player_count = HashMap::new();

        for match_result in &mut matches {
            let winner = match_result[0];
            let loser = match_result[1];

            *score.entry(winner).or_insert(0) += 1;
            *player_count.entry(winner).or_insert(0) += 1;
            *player_count.entry(loser).or_insert(0) += 1;
        }

        let mut result = Vec::new();
        for (player, count) in player_count {
            if *score.get(&player).unwrap() > 0 && *score.get(&player).unwrap() >= count {
                result.push(player);
            }
        }

        result.sort();
        result
    }
}
}
use std::collections::HashMap;

impl Solution {
    pub fn find_winners(matches: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let mut losses = HashMap::new();

        for m in matches {
            let winner = m[0];
            let loser = m[1];

            losses.entry(winner).or_insert(0);
            *losses.entry(loser).or_insert(0) += 1;
        }

        let mut zero_loss = Vec::new();
        let mut one_loss = Vec::new();

        for (&player, &count) in losses.iter() {
            if count == 0 {
                zero_loss.push(player);
            } else if count == 1 {
                one_loss.push(player);
            }
        }

        zero_loss.sort_unstable();
        one_loss.sort_unstable();

        vec![zero_loss, one_loss]
    }
}
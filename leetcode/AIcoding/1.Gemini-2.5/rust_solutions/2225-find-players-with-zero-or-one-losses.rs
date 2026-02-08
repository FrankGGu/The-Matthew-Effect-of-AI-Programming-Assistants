use std::collections::HashMap;

impl Solution {
    pub fn find_winners(matches: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let mut loss_counts: HashMap<i32, i32> = HashMap::new();

        for m in matches {
            let winner = m[0];
            let loser = m[1];

            loss_counts.entry(winner).or_insert(0);
            *loss_counts.entry(loser).or_insert(0) += 1;
        }

        let mut zero_losses = Vec::new();
        let mut one_loss = Vec::new();

        for (&player, &losses) in loss_counts.iter() {
            if losses == 0 {
                zero_losses.push(player);
            } else if losses == 1 {
                one_loss.push(player);
            }
        }

        zero_losses.sort_unstable();
        one_loss.sort_unstable();

        vec![zero_losses, one_loss]
    }
}
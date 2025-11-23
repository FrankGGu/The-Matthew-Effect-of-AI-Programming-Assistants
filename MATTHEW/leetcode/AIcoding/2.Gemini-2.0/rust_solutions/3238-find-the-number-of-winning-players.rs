use std::collections::HashMap;

impl Solution {
    pub fn find_winners(matches: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let mut losses: HashMap<i32, i32> = HashMap::new();
        for match_ in &matches {
            let winner = match_[0];
            let loser = match_[1];
            losses.entry(winner).or_insert(0);
            *losses.entry(loser).or_insert(0) += 1;
        }

        let mut zero_loss: Vec<i32> = Vec::new();
        let mut one_loss: Vec<i32> = Vec::new();

        for (&player, &loss_count) in &losses {
            if loss_count == 0 {
                zero_loss.push(player);
            } else if loss_count == 1 {
                one_loss.push(player);
            }
        }

        zero_loss.sort();
        one_loss.sort();

        let mut all_players: std::collections::HashSet<i32> = std::collections::HashSet::new();

        for match_ in &matches{
            all_players.insert(match_[0]);
            all_players.insert(match_[1]);
        }
        let mut one_loss_final: Vec<i32> = Vec::new();
        let mut zero_loss_final: Vec<i32> = Vec::new();
        for p in all_players {
            let loss_count = losses.get(&p).unwrap_or(&0);
            if *loss_count == 0{
                zero_loss_final.push(p);
            }else if *loss_count == 1{
                one_loss_final.push(p);
            }
        }
        zero_loss_final.sort();
        one_loss_final.sort();

        vec![zero_loss_final, one_loss_final]
    }
}
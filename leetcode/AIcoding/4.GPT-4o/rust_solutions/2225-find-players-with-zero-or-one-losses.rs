use std::collections::HashMap;

pub fn find_winners(matches: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
    let mut loss_count = HashMap::new();

    for match_result in matches {
        let winner = match_result[0];
        let loser = match_result[1];

        loss_count.entry(winner).or_insert(0);
        *loss_count.entry(loser).or_insert(0) += 1;
    }

    let mut result = vec![Vec::new(), Vec::new()];

    for (&player, &losses) in &loss_count {
        if losses == 0 {
            result[0].push(player);
        } else if losses == 1 {
            result[1].push(player);
        }
    }

    for players in &mut result {
        players.sort();
    }

    result
}
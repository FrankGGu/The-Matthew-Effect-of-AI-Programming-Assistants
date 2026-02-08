impl Solution {
    pub fn find_winner(matches: Vec<Vec<i32>>, k: i32) -> i32 {
        use std::collections::HashMap;

        let mut win_counts = HashMap::new();
        let mut loss_counts = HashMap::new();

        for m in matches {
            let winner = m[0];
            let loser = m[1];
            *win_counts.entry(winner).or_insert(0) += 1;
            *loss_counts.entry(loser).or_insert(0) += 1;
        }

        let mut candidates = Vec::new();
        for (&player, &wins) in win_counts.iter() {
            if !loss_counts.contains_key(&player) || *loss_counts.get(&player).unwrap() == 0 {
                if wins >= k {
                    return player;
                }
                candidates.push(player);
            }
        }

        if candidates.is_empty() {
            -1
        } else {
            *candidates.iter().min().unwrap()
        }
    }
}
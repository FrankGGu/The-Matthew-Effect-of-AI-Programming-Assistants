pub fn find_winning_players(scores: Vec<i32>) -> Vec<i32> {
    let max_score = *scores.iter().max().unwrap();
    let mut winning_players = Vec::new();

    for &score in &scores {
        if score == max_score {
            winning_players.push(score);
        }
    }

    winning_players.sort();
    winning_players.dedup();

    winning_players
}
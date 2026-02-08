pub fn first_player_to_win_k_games(k: i32, games: Vec<i32>) -> i32 {
    let mut count = 1;
    let mut last_winner = -1;

    for i in 1..games.len() {
        if games[i] == games[i - 1] {
            count += 1;
        } else {
            count = 1;
        }

        if count == k {
            last_winner = games[i];
            break;
        }
    }

    last_winner
}
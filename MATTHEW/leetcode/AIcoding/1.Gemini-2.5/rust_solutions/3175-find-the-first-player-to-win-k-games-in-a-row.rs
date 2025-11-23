impl Solution {
    pub fn get_winner(players: Vec<i32>, k: i32) -> i32 {
        // If k is very large, the player with the maximum value will eventually win
        // all games against other players. The maximum number of distinct opponents
        // a player can face is players.len() - 1. If k is greater than or equal to this,
        // the maximum element is guaranteed to win k games in a row.
        if k as usize >= players.len() - 1 {
            return *players.iter().max().unwrap();
        }

        let mut current_winner = players[0];
        let mut consecutive_wins = 0;

        // Simulate games starting from the second player
        for i in 1..players.len() {
            let challenger = players[i];

            if current_winner > challenger {
                // Current winner wins the game
                consecutive_wins += 1;
            } else {
                // Challenger wins, becomes the new current_winner
                current_winner = challenger;
                consecutive_wins = 1; // Resets to 1 win for the new winner
            }

            // Check if the current winner has achieved k consecutive wins
            if consecutive_wins == k {
                return current_winner;
            }
        }

        // This line should be reached only if the loop completes without finding a winner
        // that satisfies `k` consecutive wins. This implies that the `current_winner`
        // at the end of the array is the one who won all remaining games but didn't
        // reach `k` wins before exhausting all challengers. However, given the problem
        // constraints and the early exit for large `k`, this path is generally
        // not expected to be taken if a solution is guaranteed by the problem.
        // It serves as a fallback, returning the last standing winner.
        current_winner
    }
}
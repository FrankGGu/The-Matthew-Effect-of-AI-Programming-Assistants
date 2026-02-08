impl Solution {
    pub fn maximum_matching(mut players: Vec<i32>, mut trainers: Vec<i32>) -> i32 {
        players.sort_unstable();
        trainers.sort_unstable();

        let mut player_idx = 0;
        let mut trainer_idx = 0;
        let mut matches = 0;

        while player_idx < players.len() && trainer_idx < trainers.len() {
            if players[player_idx] <= trainers[trainer_idx] {
                matches += 1;
                player_idx += 1;
                trainer_idx += 1;
            } else {
                trainer_idx += 1;
            }
        }

        matches
    }
}
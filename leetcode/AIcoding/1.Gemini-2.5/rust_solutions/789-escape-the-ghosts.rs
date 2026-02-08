impl Solution {
    pub fn escape_ghosts(ghosts: Vec<Vec<i32>>, target: Vec<i32>) -> bool {
        let player_time = target[0].abs() + target[1].abs();

        for ghost in ghosts {
            let ghost_time = (target[0] - ghost[0]).abs() + (target[1] - ghost[1]).abs();
            if ghost_time <= player_time {
                return false;
            }
        }

        true
    }
}
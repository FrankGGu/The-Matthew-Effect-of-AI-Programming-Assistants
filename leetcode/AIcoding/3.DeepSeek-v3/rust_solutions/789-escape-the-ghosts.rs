impl Solution {
    pub fn escape_ghosts(ghosts: Vec<Vec<i32>>, target: Vec<i32>) -> bool {
        let player_dist = target[0].abs() + target[1].abs();
        for ghost in ghosts {
            let ghost_dist = (ghost[0] - target[0]).abs() + (ghost[1] - target[1]).abs();
            if ghost_dist <= player_dist {
                return false;
            }
        }
        true
    }
}
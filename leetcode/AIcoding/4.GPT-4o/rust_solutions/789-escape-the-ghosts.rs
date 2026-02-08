pub fn escape_ghosts(ghosts: Vec<Vec<i32>>, target: Vec<i32>) -> bool {
    let (tx, ty) = (target[0], target[1]);
    let (px, py) = (0, 0);
    let player_distance = (tx - px).abs() + (ty - py).abs();

    for ghost in ghosts {
        let (gx, gy) = (ghost[0], ghost[1]);
        let ghost_distance = (tx - gx).abs() + (ty - gy).abs();
        if ghost_distance <= player_distance {
            return false;
        }
    }

    true
}
pub fn furthest_distance_from_origin(moves: String) -> i32 {
    let (mut x, mut y) = (0, 0);
    for ch in moves.chars() {
        match ch {
            'L' => x -= 1,
            'R' => x += 1,
            'U' => y += 1,
            'D' => y -= 1,
            _ => {},
        }
    }
    let mut distance = x.abs() + y.abs();
    let unknown_moves = moves.chars().filter(|&c| c == '?').count();
    distance + unknown_moves as i32
}
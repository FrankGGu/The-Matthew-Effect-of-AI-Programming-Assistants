impl Solution {
    pub fn furthest_point_from_origin(moves: String) -> i32 {
        let mut pos = 0;
        let mut unknown_count = 0;

        for c in moves.chars() {
            match c {
                'L' => pos -= 1,
                'R' => pos += 1,
                '_' => unknown_count += 1,
                _ => {}
            }
        }

        pos.abs() + unknown_count
    }
}
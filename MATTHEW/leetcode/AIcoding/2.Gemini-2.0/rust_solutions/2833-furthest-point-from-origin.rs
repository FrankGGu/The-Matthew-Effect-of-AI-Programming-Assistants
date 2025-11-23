impl Solution {
    pub fn furthest_point(moves: String) -> i32 {
        let mut l_count = 0;
        let mut r_count = 0;
        let mut underscore_count = 0;

        for c in moves.chars() {
            match c {
                'L' => l_count += 1,
                'R' => r_count += 1,
                '_' => underscore_count += 1,
                _ => {}
            }
        }

        (l_count - r_count).abs() + underscore_count
    }
}
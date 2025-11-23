impl Solution {
    pub fn furthest_distance_from_origin(moves: String) -> i32 {
        let mut l = 0;
        let mut r = 0;
        let mut wild = 0;

        for c in moves.chars() {
            match c {
                'L' => l += 1,
                'R' => r += 1,
                _ => wild += 1,
            }
        }

        (l - r).abs() + wild
    }
}
impl Solution {
    pub fn flip_lights(n: i32, presses: i32) -> i32 {
        let n = std::cmp::min(n, 3);
        if presses == 0 {
            return 1;
        }
        if presses == 1 {
            match n {
                1 => 2,
                2 => 3,
                _ => 4,
            }
        } else if presses == 2 {
            match n {
                1 => 2,
                2 => 4,
                _ => 7,
            }
        } else {
            match n {
                1 => 2,
                2 => 4,
                _ => 8,
            }
        }
    }
}
impl Solution {
    pub fn flip_lights(n: i32, m: i32) -> i32 {
        if m == 0 {
            return 1;
        }

        match n {
            1 => 2,
            2 => match m {
                1 => 3,
                _ => 4,
            },
            _ => match m { // n >= 3
                1 => 4,
                2 => 7,
                _ => 8,
            },
        }
    }
}
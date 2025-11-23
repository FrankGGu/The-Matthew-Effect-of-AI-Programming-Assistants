struct Solution;

impl Solution {
    pub fn reachable_target(mut x: i32, mut y: i32) -> bool {
        while x < y {
            let temp = y % x;
            y = x;
            x = temp;
        }
        x == 0 && y != 0 || x == y
    }
}
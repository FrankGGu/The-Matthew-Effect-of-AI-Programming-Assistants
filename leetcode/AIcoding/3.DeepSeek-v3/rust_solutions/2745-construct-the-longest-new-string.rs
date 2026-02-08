impl Solution {
    pub fn longest_string(x: i32, y: i32, z: i32) -> i32 {
        let min_xy = std::cmp::min(x, y);
        if x == y {
            (x + y + z) * 2
        } else {
            (min_xy * 2 + 1 + z) * 2
        }
    }
}
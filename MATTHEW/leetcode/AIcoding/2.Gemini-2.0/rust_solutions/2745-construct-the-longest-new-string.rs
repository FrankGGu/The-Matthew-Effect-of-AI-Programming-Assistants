impl Solution {
    pub fn longest_new_string(x: i32, y: i32, z: i32) -> i32 {
        if x == y {
            (x + y + z) * 2
        } else {
            (std::cmp::min(x, y) * 2 + 1 + z) * 2
        }
    }
}
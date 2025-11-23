impl Solution {
    pub fn smallest_number(k: i32) -> i32 {
        (1 << k) - 1
    }
}
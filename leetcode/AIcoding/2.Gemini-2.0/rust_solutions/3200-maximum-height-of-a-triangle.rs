impl Solution {
    pub fn max_height(base: i32, area: i32) -> i32 {
        (2.0 * area as f64 / base as f64).floor() as i32
    }
}
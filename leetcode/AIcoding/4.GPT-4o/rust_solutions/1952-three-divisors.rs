impl Solution {
    pub fn is_three(n: i32) -> bool {
        if n < 4 { return false; }
        let sqrt_n = (n as f64).sqrt() as i32;
        sqrt_n * sqrt_n == n && (sqrt_n as f64).sqrt() as i32 * (sqrt_n as f64).sqrt() as i32 == sqrt_n
    }
}
impl Solution {
    pub fn toy_circle(n: i32, start: i32, k: i32) -> i32 {
        ((start + k) % n + n) % n
    }
}
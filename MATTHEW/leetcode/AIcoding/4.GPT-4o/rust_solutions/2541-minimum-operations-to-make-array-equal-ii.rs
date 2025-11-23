impl Solution {
    pub fn min_operations(n: i32) -> i32 {
        if n % 2 == 0 {
            n * (n / 2) / 2
        } else {
            (n / 2 + 1) * (n / 2)
        }
    }
}
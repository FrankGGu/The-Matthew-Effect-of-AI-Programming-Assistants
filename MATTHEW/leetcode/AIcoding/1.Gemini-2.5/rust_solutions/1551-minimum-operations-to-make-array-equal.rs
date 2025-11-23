impl Solution {
    pub fn min_operations(n: i32) -> i32 {
        let k = n / 2;
        k * (k + (n % 2))
    }
}
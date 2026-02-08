impl Solution {
    pub fn is_power_of_four(n: i32) -> bool {
        if n <= 0 {
            return false;
        }
        n & (n - 1) == 0 && (n - 1) % 3 == 0
    }
}
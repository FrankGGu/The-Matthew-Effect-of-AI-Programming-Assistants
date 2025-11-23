impl Solution {
    pub fn is_power_of_three(n: i32) -> bool {
        if n <= 0 {
            return false;
        }
        // The largest power of 3 that fits within a signed 32-bit integer (i32::MAX = 2,147,483,647)
        // is 3^19 = 1,162,261,467.
        // If n is a power of three, then 1,162,261,467 must be divisible by n.
        1162261467 % n == 0
    }
}
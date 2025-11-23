impl Solution {
    pub fn construct_minimum_bitwise_array(n: i32) -> i32 {
        if n == 1 {
            0
        } else {
            1 << (n - 2)
        }
    }
}
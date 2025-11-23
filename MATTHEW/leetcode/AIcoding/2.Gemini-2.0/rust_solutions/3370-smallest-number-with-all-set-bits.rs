impl Solution {
    pub fn smallest_number_with_all_set_bits(n: i32) -> i32 {
        (1 << n) - 1
    }
}
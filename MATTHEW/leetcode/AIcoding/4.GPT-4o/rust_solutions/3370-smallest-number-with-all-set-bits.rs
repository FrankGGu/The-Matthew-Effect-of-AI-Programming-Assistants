impl Solution {
    pub fn smallest_number_with_set_bits(n: i32) -> i32 {
        let mut result = 0;
        for i in 0..n {
            result |= 1 << i;
        }
        result
    }
}
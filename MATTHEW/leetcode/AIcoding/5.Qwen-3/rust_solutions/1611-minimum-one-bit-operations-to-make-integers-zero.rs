struct Solution;

impl Solution {
    pub fn minimum_one_bit_operations(n: i32) -> i32 {
        let mut res = 0;
        let mut n = n;
        while n > 0 {
            res ^= n;
            n >>= 1;
        }
        res
    }
}
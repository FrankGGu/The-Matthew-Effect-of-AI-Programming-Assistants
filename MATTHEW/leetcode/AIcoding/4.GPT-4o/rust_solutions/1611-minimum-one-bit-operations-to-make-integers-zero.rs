impl Solution {
    pub fn minimum_one_bit_operations(n: i32) -> i32 {
        let mut res = 0;
        let mut mask = n;
        while mask > 0 {
            res ^= mask;
            mask >>= 1;
        }
        res
    }
}
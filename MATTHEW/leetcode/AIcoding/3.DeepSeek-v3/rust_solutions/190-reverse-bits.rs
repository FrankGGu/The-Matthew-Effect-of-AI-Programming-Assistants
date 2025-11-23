impl Solution {
    pub fn reverse_bits(x: u32) -> u32 {
        let mut res = 0;
        for i in 0..32 {
            res |= ((x >> i) & 1) << (31 - i);
        }
        res
    }
}
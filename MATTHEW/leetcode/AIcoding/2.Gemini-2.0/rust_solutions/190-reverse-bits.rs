impl Solution {
    pub fn reverse_bits(x: u32) -> u32 {
        let mut res: u32 = 0;
        let mut num: u32 = x;

        for _i in 0..32 {
            res <<= 1;
            res |= num & 1;
            num >>= 1;
        }

        res
    }
}
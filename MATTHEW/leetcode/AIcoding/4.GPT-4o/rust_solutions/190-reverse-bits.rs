impl Solution {
    pub fn reverse_bits(n: u32) -> u32 {
        let mut result = 0;
        let mut n = n;

        for _ in 0..32 {
            result <<= 1;
            result |= n & 1;
            n >>= 1;
        }

        result
    }
}
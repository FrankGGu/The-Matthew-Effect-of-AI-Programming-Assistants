impl Solution {
    pub fn reverse_bits(n: u32) -> u32 {
        let mut reversed_n: u32 = 0;
        let mut num = n;

        for _ in 0..32 {
            reversed_n <<= 1;
            reversed_n |= (num & 1);
            num >>= 1;
        }
        reversed_n
    }
}
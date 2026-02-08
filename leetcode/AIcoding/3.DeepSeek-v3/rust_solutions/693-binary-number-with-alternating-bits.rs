impl Solution {
    pub fn has_alternating_bits(n: i32) -> bool {
        let n = n as u32;
        let a = (n ^ (n >> 1)) + 1;
        a & (a - 1) == 0
    }
}
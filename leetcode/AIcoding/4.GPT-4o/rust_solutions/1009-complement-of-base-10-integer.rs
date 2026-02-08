impl Solution {
    pub fn bitwise_complement(n: i32) -> i32 {
        let mut mask = 1;
        while mask <= n {
            mask <<= 1;
        }
        mask - 1 - n
    }
}
struct Solution {}

impl Solution {
    pub fn bitwise_complement(n: i32) -> i32 {
        if n == 0 {
            return 1;
        }
        let mut mask = 1;
        while mask < n {
            mask = (mask << 1) | 1;
        }
        n ^ mask
    }
}
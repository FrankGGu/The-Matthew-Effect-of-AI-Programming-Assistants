struct Solution {}

impl Solution {
    pub fn find_complement(mut num: u32) -> u32 {
        let mut mask = 1;
        while mask < num {
            mask = (mask << 1) | 1;
        }
        num ^ mask
    }
}
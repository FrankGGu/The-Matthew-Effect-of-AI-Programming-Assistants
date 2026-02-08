impl Solution {
    pub fn find_complement(num: i32) -> i32 {
        let mut mask: i32 = 1;
        while mask < num {
            mask = (mask << 1) | 1;
        }
        num ^ mask
    }
}
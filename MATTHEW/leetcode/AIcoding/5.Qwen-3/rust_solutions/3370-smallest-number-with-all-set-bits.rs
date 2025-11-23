struct Solution {}

impl Solution {
    pub fn smallest_number(mut n: i32) -> i32 {
        if n == 0 {
            return 0;
        }
        let mut mask = 1;
        while mask < n {
            mask = (mask << 1) | 1;
        }
        mask
    }
}
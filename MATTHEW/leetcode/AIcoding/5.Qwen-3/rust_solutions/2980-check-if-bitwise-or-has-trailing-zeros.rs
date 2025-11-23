impl Solution {

use std::vec;

impl Solution {
    pub fn has_trailing_zeros(nums: Vec<i32>) -> bool {
        let mut count = 0;
        for num in nums {
            if num & 1 == 0 {
                count += 1;
            }
        }
        count >= 2
    }
}
}
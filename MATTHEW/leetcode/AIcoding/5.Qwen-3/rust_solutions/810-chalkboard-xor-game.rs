impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn xor_game(mut nums: Vec<i32>) -> bool {
        let mut xor_sum = 0;
        for num in &nums {
            xor_sum ^= *num;
        }
        if xor_sum == 0 {
            return true;
        }
        nums.len() % 2 == 0
    }
}
}
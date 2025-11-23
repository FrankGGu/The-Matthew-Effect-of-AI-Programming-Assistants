impl Solution {

use std::cmp;

impl Solution {
    pub fn min_moves(mut nums: Vec<i32>) -> i32 {
        if nums.is_empty() {
            return 0;
        }
        let min = *nums.iter().min().unwrap();
        let mut moves = 0;
        for num in nums.iter_mut() {
            moves += *num - min;
        }
        moves
    }
}
}
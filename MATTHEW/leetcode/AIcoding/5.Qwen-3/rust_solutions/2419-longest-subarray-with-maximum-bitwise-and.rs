impl Solution {

use std::cmp;

impl Solution {
    pub fn longest_subarray(nums: Vec<i32>) -> i32 {
        let mut max_val = 0;
        let mut max_len = 0;
        let mut current_len = 0;

        for num in &nums {
            if *num > max_val {
                max_val = *num;
                current_len = 1;
                max_len = 1;
            } else if *num == max_val {
                current_len += 1;
                max_len = cmp::max(max_len, current_len);
            } else {
                current_len = 0;
            }
        }

        max_len
    }
}
}
impl Solution {

use std::cmp::min;

struct Solution {}

impl Solution {
    pub fn longest_common_prefix(nums: Vec<i32>) -> i32 {
        if nums.is_empty() {
            return 0;
        }

        let mut prefix = nums[0].to_string();

        for num in nums.iter().skip(1) {
            let s = num.to_string();
            let mut i = 0;
            while i < min(prefix.len(), s.len()) && prefix.chars().nth(i) == s.chars().nth(i) {
                i += 1;
            }
            prefix.truncate(i);
            if prefix.is_empty() {
                break;
            }
        }

        prefix.len() as i32
    }
}
}
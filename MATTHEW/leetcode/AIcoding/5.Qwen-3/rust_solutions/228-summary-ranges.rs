impl Solution {

use std::vec::Vec;

impl Solution {
    pub fn summary_ranges(nums: Vec<i32>) -> Vec<String> {
        if nums.is_empty() {
            return Vec::new();
        }

        let mut result = Vec::new();
        let mut start = nums[0];

        for i in 1..nums.len() {
            if nums[i] != nums[i - 1] + 1 {
                if start == nums[i - 1] {
                    result.push(format!("{}", start));
                } else {
                    result.push(format!("{}->{}", start, nums[i - 1]));
                }
                start = nums[i];
            }
        }

        if start == nums.last().unwrap() {
            result.push(format!("{}", start));
        } else {
            result.push(format!("{}->{}", start, nums.last().unwrap()));
        }

        result
    }
}
}
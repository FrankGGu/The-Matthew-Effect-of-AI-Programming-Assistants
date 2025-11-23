impl Solution {

use std::collections::HashSet;

struct Solution {}

impl Solution {
    pub fn first_missing_positive(nums: &mut Vec<i32>) -> i32 {
        let n = nums.len();
        for i in 0..n {
            while nums[i] > 0 && nums[i] <= n as i32 && nums[nums[i] as usize - 1] != nums[i] {
                let correct_idx = nums[i] as usize - 1;
                if nums[correct_idx] != nums[i] {
                    nums.swap(i, correct_idx);
                } else {
                    break;
                }
            }
        }

        for i in 0..n {
            if nums[i] != (i + 1) as i32 {
                return (i + 1) as i32;
            }
        }

        (n + 1) as i32
    }
}
}
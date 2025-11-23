impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn min_length_after_ops(nums: Vec<i32>, x: i32) -> i32 {
        let mut nums = nums;
        let n = nums.len();
        let mut set = HashSet::new();
        for &num in &nums {
            set.insert(num);
        }
        let mut count = set.len();
        let mut i = 0;
        while i < n {
            if i + 1 < n && nums[i] > nums[i + 1] {
                let diff = nums[i] - nums[i + 1];
                if diff <= x {
                    nums[i + 1] += diff;
                    set.remove(&nums[i]);
                    set.insert(nums[i + 1]);
                    count -= 1;
                    i += 1;
                } else {
                    break;
                }
            } else {
                i += 1;
            }
        }
        count as i32
    }
}
}
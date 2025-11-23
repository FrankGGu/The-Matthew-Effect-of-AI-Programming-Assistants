impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn can_partition(nums: Vec<i32>) -> bool {
        let total_sum: i32 = nums.iter().sum();
        if total_sum % 2 != 0 {
            return false;
        }
        let target = total_sum / 2;
        let mut dp = HashSet::new();
        dp.insert(0);
        for &num in &nums {
            let mut new_dp = dp.clone();
            for &prev in &dp {
                let next = prev + num;
                if next == target {
                    return true;
                }
                if next < target {
                    new_dp.insert(next);
                }
            }
            dp = new_dp;
        }
        false
    }
}
}
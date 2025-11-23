impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn find_target_sum_ways(nums: Vec<i32>, target: i32) -> i32 {
        let mut dp = HashMap::new();
        dp.insert(0, 1);

        for num in nums {
            let mut next_dp = HashMap::new();
            for (&sum, &count) in &dp {
                next_dp.entry(sum + num).and_modify(|e| *e += count).or_insert(count);
                next_dp.entry(sum - num).and_modify(|e| *e += count).or_insert(count);
            }
            dp = next_dp;
        }

        dp.get(&target).copied().unwrap_or(0)
    }
}
}
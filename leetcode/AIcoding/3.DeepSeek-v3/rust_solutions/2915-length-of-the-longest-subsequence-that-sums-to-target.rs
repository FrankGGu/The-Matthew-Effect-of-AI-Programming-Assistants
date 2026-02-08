use std::collections::HashMap;

impl Solution {
    pub fn length_of_longest_subsequence(nums: Vec<i32>, target: i32) -> i32 {
        let mut dp = HashMap::new();
        dp.insert(0, 0);
        for num in nums {
            let mut new_dp = dp.clone();
            for (&sum, &len) in dp.iter() {
                let new_sum = sum + num;
                if new_sum <= target {
                    let entry = new_dp.entry(new_sum).or_insert(0);
                    *entry = (*entry).max(len + 1);
                }
            }
            dp = new_dp;
        }
        *dp.get(&target).unwrap_or(&-1)
    }
}
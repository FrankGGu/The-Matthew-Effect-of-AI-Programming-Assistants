impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn max_frequency(mut nums: Vec<i32>, mut k: i32) -> i32 {
        nums.sort();
        let mut freq = HashMap::new();
        let mut max_freq = 0;
        let mut left = 0;

        for right in 0..nums.len() {
            *freq.entry(nums[right]).or_insert(0) += 1;
            while (nums[right] as i64 - nums[left] as i64) * (freq[&nums[right]] as i64) > k as i64 {
                *freq.entry(nums[left]).or_insert(0) -= 1;
                if freq[&nums[left]] == 0 {
                    freq.remove(&nums[left]);
                }
                left += 1;
            }
            max_freq = max_freq.max(freq[&nums[right]]);
        }

        max_freq
    }
}
}
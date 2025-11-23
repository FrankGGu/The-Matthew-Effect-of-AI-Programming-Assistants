impl Solution {

use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn max_frequency(mut nums: Vec<i32>, mut k: i32) -> i32 {
        nums.sort();
        let mut count = HashMap::new();
        let mut max_freq = 0;
        let mut left = 0;

        for right in 0..nums.len() {
            *count.entry(nums[right]).or_insert(0) += 1;
            max_freq = max_freq.max(*count.get(&nums[right]).unwrap());

            while (nums[right] as i64 * (right as i64 - left as i64 + 1) - k as i64) > k as i64 {
                *count.entry(nums[left]).or_insert(0) -= 1;
                if count[&nums[left]] == 0 {
                    count.remove(&nums[left]);
                }
                left += 1;
            }
        }

        max_freq
    }
}
}
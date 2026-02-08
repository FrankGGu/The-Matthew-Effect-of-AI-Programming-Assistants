use std::collections::HashMap;

impl Solution {
    pub fn most_frequent(nums: Vec<i32>, key: i32) -> i32 {
        let mut counts: HashMap<i32, i32> = HashMap::new();

        for i in 0..nums.len() - 1 {
            if nums[i] == key {
                let target = nums[i + 1];
                *counts.entry(target).or_insert(0) += 1;
            }
        }

        let mut max_freq = 0;
        let mut result_target = 0;

        for (&target, &freq) in counts.iter() {
            if freq > max_freq {
                max_freq = freq;
                result_target = target;
            } else if freq == max_freq {
                result_target = result_target.min(target);
            }
        }

        result_target
    }
}
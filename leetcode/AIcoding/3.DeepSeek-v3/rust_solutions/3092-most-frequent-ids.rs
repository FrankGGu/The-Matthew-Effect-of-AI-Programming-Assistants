use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn most_frequent_ids(nums: Vec<i32>, freq: Vec<i32>) -> Vec<i64> {
        let mut count = HashMap::new();
        let mut max = 0;
        let mut res = Vec::with_capacity(nums.len());

        for i in 0..nums.len() {
            let id = nums[i] as i64;
            let delta = freq[i] as i64;
            let entry = count.entry(id).or_insert(0);
            *entry += delta;

            if *entry > max {
                max = *entry;
            } else if *entry == max - delta && delta < 0 {
                max = *count.values().max().unwrap_or(&0);
            }

            res.push(max);
        }

        res
    }
}
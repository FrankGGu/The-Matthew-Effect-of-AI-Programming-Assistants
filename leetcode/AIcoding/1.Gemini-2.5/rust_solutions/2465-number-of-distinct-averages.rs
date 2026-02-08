use std::collections::HashSet;

impl Solution {
    pub fn distinct_averages(mut nums: Vec<i32>) -> i32 {
        nums.sort_unstable();
        let mut distinct_averages_set: HashSet<f64> = HashSet::new();
        let mut left = 0;
        let mut right = nums.len() - 1;

        while left < right {
            let min_val = nums[left] as f64;
            let max_val = nums[right] as f64;
            let average = (min_val + max_val) / 2.0;
            distinct_averages_set.insert(average);
            left += 1;
            right -= 1;
        }

        distinct_averages_set.len() as i32
    }
}
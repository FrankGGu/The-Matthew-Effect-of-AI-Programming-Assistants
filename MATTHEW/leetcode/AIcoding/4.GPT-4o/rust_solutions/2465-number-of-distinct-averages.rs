use std::collections::HashSet;

impl Solution {
    pub fn distinct_averages(nums: Vec<i32>) -> i32 {
        let mut nums = nums;
        nums.sort();
        let mut averages = HashSet::new();
        let n = nums.len();

        for i in 0..n / 2 {
            let avg = (nums[i] + nums[n - 1 - i]) as f64 / 2.0;
            averages.insert(avg);
        }

        averages.len() as i32
    }
}
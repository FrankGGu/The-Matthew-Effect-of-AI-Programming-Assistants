use std::collections::HashSet;

impl Solution {
    pub fn max_sum(nums: Vec<i32>, m: i32, k: i32) -> i64 {
        let mut max_sum = 0;
        let mut current_sum = 0i64;
        let mut freq = HashSet::new();
        let k = k as usize;

        for i in 0..nums.len() {
            if i >= k {
                let left = nums[i - k];
                current_sum -= left as i64;
                freq.remove(&left);
            }

            current_sum += nums[i] as i64;
            freq.insert(nums[i]);

            if i >= k - 1 && freq.len() >= m as usize {
                if current_sum > max_sum {
                    max_sum = current_sum;
                }
            }
        }

        max_sum
    }
}
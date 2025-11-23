use std::collections::HashSet;

impl Solution {
    pub fn maximum_subarray_sum(nums: Vec<i32>, k: i32) -> i64 {
        let k = k as usize;
        let mut max_sum = 0i64;
        let mut current_sum = 0i64;
        let mut unique = HashSet::new();
        let mut left = 0;

        for right in 0..nums.len() {
            while unique.contains(&nums[right]) {
                unique.remove(&nums[left]);
                current_sum -= nums[left] as i64;
                left += 1;
            }
            unique.insert(nums[right]);
            current_sum += nums[right] as i64;

            if right - left + 1 == k {
                if current_sum > max_sum {
                    max_sum = current_sum;
                }
                unique.remove(&nums[left]);
                current_sum -= nums[left] as i64;
                left += 1;
            }
        }

        max_sum
    }
}
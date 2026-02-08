use std::collections::HashSet;

impl Solution {
    pub fn maximum_sum(nums: Vec<i32>, k: i32) -> i64 {
        let k = k as usize;
        let mut max_sum: i64 = 0;
        let mut current_sum: i64 = 0;
        let mut seen: HashSet<i32> = HashSet::new();
        let mut left: usize = 0;

        for right in 0..nums.len() {
            while seen.contains(&nums[right]) {
                seen.remove(&nums[left]);
                current_sum -= nums[left] as i64;
                left += 1;
            }

            seen.insert(nums[right]);
            current_sum += nums[right] as i64;

            if right - left + 1 == k {
                max_sum = max_sum.max(current_sum);
                seen.remove(&nums[left]);
                current_sum -= nums[left] as i64;
                left += 1;
            }
        }

        max_sum
    }
}
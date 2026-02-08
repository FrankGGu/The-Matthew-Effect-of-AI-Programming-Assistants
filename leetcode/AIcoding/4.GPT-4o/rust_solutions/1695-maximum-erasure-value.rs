impl Solution {
    pub fn maximum_unique_subarray(nums: Vec<i32>) -> i32 {
        let mut seen = std::collections::HashSet::new();
        let mut left = 0;
        let mut current_sum = 0;
        let mut max_sum = 0;

        for right in 0..nums.len() {
            while seen.contains(&nums[right]) {
                seen.remove(&nums[left]);
                current_sum -= nums[left];
                left += 1;
            }
            seen.insert(nums[right]);
            current_sum += nums[right];
            max_sum = max_sum.max(current_sum);
        }

        max_sum
    }
}
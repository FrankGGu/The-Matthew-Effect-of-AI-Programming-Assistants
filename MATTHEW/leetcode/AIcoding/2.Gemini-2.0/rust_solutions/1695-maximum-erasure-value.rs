impl Solution {
    pub fn maximum_unique_subarray(nums: Vec<i32>) -> i32 {
        let mut max_sum = 0;
        let mut current_sum = 0;
        let mut start = 0;
        let mut seen = std::collections::HashSet::new();

        for end in 0..nums.len() {
            while seen.contains(&nums[end]) {
                seen.remove(&nums[start]);
                current_sum -= nums[start];
                start += 1;
            }
            seen.insert(nums[end]);
            current_sum += nums[end];
            max_sum = max_sum.max(current_sum);
        }

        max_sum
    }
}
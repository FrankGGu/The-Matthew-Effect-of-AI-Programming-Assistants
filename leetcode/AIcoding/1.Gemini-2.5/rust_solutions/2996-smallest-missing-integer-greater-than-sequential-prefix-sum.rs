use std::collections::HashSet;

impl Solution {
    pub fn smallest_missing_integer(nums: Vec<i32>) -> i32 {
        let n = nums.len();

        let mut sequential_prefix_sum = nums[0];
        let mut k = 1; // k is the index where the sequential prefix ends (exclusive)

        while k < n && nums[k] == nums[k - 1] + 1 {
            sequential_prefix_sum += nums[k];
            k += 1;
        }

        let mut suffix_set = HashSet::new();
        for i in k..n {
            suffix_set.insert(nums[i]);
        }

        let mut candidate = sequential_prefix_sum + 1;
        while suffix_set.contains(&candidate) {
            candidate += 1;
        }

        candidate
    }
}
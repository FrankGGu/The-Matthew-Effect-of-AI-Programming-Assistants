impl Solution {
    pub fn count_max_or_subsets(nums: Vec<i32>) -> i32 {
        let mut max_or_value = 0;
        for &num in &nums {
            max_or_value |= num;
        }

        let mut count = 0;
        Self::backtrack(&nums, 0, 0, max_or_value, &mut count);
        count
    }

    fn backtrack(nums: &[i32], index: usize, current_or: i32, target_or: i32, count: &mut i32) {
        if index == nums.len() {
            if current_or == target_or {
                *count += 1;
            }
            return;
        }

        // Include nums[index] in the current subset
        Self::backtrack(nums, index + 1, current_or | nums[index], target_or, count);

        // Exclude nums[index] from the current subset
        Self::backtrack(nums, index + 1, current_or, target_or, count);
    }
}
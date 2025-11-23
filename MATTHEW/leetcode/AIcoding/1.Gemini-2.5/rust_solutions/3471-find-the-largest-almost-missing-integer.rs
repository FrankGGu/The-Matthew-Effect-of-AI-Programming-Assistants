use std::collections::HashSet;
use std::cmp::max;

impl Solution {
    pub fn find_the_largest_almost_missing_integer(nums: Vec<i32>) -> i32 {
        if nums.is_empty() {
            return i32::MIN;
        }

        let num_set: HashSet<i32> = nums.iter().cloned().collect();
        let mut max_almost_missing = i32::MIN;

        for &num in &nums {
            if num < i32::MAX && !num_set.contains(&(num + 1)) {
                max_almost_missing = max(max_almost_missing, num + 1);
            }

            if num > i32::MIN && !num_set.contains(&(num - 1)) {
                max_almost_missing = max(max_almost_missing, num - 1);
            }
        }

        max_almost_missing
    }
}
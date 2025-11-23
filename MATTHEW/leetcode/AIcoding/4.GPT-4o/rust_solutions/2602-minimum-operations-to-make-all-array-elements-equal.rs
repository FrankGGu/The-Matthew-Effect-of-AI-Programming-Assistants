impl Solution {
    pub fn min_operations(nums: Vec<i32>) -> i32 {
        let mut unique_nums = nums.into_iter().collect::<std::collections::HashSet<_>>();
        unique_nums.len() as i32 - 1
    }
}
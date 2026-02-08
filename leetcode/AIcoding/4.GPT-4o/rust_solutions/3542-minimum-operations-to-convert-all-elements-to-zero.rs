impl Solution {
    pub fn minimum_operations(nums: Vec<i32>) -> i32 {
        let mut unique_non_zero = nums.iter().filter(|&&x| x > 0).collect::<std::collections::HashSet<_>>().len();
        unique_non_zero as i32
    }
}
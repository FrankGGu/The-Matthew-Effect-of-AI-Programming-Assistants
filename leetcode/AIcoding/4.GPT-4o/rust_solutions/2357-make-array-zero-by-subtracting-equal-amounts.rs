impl Solution {
    pub fn minimum_operations(nums: Vec<i32>) -> i32 {
        let mut unique_non_zero = std::collections::HashSet::new();
        for &num in &nums {
            if num > 0 {
                unique_non_zero.insert(num);
            }
        }
        unique_non_zero.len() as i32
    }
}
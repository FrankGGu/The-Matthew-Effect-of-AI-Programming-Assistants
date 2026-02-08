impl Solution {
    pub fn minimum_operations(nums: Vec<i32>) -> i32 {
        let mut unique_positive = std::collections::HashSet::new();
        for &num in &nums {
            if num > 0 {
                unique_positive.insert(num);
            }
        }
        unique_positive.len() as i32
    }
}
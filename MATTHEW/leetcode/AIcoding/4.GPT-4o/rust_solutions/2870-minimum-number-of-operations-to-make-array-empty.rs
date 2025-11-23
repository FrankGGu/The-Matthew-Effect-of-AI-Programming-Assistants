impl Solution {
    pub fn min_operations(nums: Vec<i32>) -> i32 {
        let mut unique_nums = std::collections::HashSet::new();
        for num in nums {
            unique_nums.insert(num);
        }
        unique_nums.len() as i32
    }
}
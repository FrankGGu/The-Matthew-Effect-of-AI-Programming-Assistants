impl Solution {
    pub fn minimum_operations(nums: Vec<i32>) -> i32 {
        let mut unique_positive = nums.iter().filter(|&&x| x > 0).collect::<std::collections::HashSet<_>>();
        unique_positive.len() as i32
    }
}
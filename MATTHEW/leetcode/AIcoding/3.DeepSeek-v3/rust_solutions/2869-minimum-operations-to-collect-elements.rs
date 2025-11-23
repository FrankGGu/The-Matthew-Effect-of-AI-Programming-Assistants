use std::collections::HashSet;

impl Solution {
    pub fn min_operations(nums: Vec<i32>, k: i32) -> i32 {
        let mut collected = HashSet::new();
        let mut operations = 0;
        for &num in nums.iter().rev() {
            operations += 1;
            if num <= k {
                collected.insert(num);
                if collected.len() == k as usize {
                    break;
                }
            }
        }
        operations
    }
}
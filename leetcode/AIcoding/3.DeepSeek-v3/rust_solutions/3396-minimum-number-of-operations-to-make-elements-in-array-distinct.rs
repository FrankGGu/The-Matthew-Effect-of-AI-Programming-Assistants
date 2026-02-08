use std::collections::HashSet;

impl Solution {
    pub fn min_operations(nums: Vec<i32>) -> i32 {
        let mut set = HashSet::new();
        let mut operations = 0;

        for &num in nums.iter() {
            let mut current = num;
            while set.contains(&current) {
                current += 1;
                operations += 1;
            }
            set.insert(current);
        }

        operations
    }
}
use std::collections::HashSet;

impl Solution {
    pub fn min_operations(nums: Vec<i32>, k: i32) -> i32 {
        let mut collected_elements: HashSet<i32> = HashSet::new();
        let mut operations_count: i32 = 0;

        for i in (0..nums.len()).rev() {
            operations_count += 1;
            let num = nums[i];

            if num >= 1 && num <= k {
                collected_elements.insert(num);
            }

            if collected_elements.len() == k as usize {
                return operations_count;
            }
        }

        operations_count
    }
}
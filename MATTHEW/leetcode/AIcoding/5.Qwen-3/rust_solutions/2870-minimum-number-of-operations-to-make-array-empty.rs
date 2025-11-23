impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn min_operations(nums: Vec<i32>) -> i32 {
        let mut count = HashMap::new();
        for num in nums {
            *count.entry(num).or_insert(0) += 1;
        }

        let mut operations = 0;
        for &freq in count.values() {
            if freq == 1 {
                return -1;
            }
            operations += freq / 3;
            if freq % 3 != 0 {
                operations += 1;
            }
        }

        operations
    }
}
}
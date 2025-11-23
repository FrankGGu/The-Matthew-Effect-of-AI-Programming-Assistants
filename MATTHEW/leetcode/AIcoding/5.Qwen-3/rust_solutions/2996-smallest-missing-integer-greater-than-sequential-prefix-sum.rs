impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn missing_integer(nums: Vec<i32>) -> i32 {
        let mut prefix_sums = HashSet::new();
        let mut current_sum = 0;

        for &num in &nums {
            current_sum += num;
            prefix_sums.insert(current_sum);
        }

        let mut i = 1;
        while prefix_sums.contains(&i) {
            i += 1;
        }

        i
    }
}
}
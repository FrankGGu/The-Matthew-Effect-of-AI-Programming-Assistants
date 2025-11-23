impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn max_number_of_non_overlapping_subarrays(nums: Vec<i32>, target: i32) -> i32 {
        let mut prefix_sum = 0;
        let mut set = HashSet::new();
        set.insert(0);
        let mut count = 0;

        for num in nums {
            prefix_sum += num;
            if set.contains(&(prefix_sum - target)) {
                count += 1;
                set.clear();
                set.insert(0);
                prefix_sum = 0;
            } else {
                set.insert(prefix_sum);
            }
        }

        count
    }
}
}
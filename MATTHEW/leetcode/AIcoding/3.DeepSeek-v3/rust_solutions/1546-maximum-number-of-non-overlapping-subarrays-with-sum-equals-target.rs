use std::collections::HashSet;

impl Solution {
    pub fn max_non_overlapping(nums: Vec<i32>, target: i32) -> i32 {
        let mut prefix_sum = 0;
        let mut seen = HashSet::new();
        seen.insert(0);
        let mut count = 0;

        for &num in nums.iter() {
            prefix_sum += num;
            if seen.contains(&(prefix_sum - target)) {
                count += 1;
                seen.clear();
                seen.insert(0);
                prefix_sum = 0;
            } else {
                seen.insert(prefix_sum);
            }
        }

        count
    }
}
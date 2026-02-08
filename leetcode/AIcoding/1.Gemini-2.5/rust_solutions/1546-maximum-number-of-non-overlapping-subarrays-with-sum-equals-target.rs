use std::collections::HashSet;

impl Solution {
    pub fn max_non_overlapping_subarrays(nums: Vec<i32>, target: i32) -> i32 {
        let mut count = 0;
        let mut current_sum = 0;
        let mut seen_sums: HashSet<i32> = HashSet::new();
        seen_sums.insert(0);

        for num in nums {
            current_sum += num;
            if seen_sums.contains(&(current_sum - target)) {
                count += 1;
                current_sum = 0;
                seen_sums.clear();
                seen_sums.insert(0);
            } else {
                seen_sums.insert(current_sum);
            }
        }
        count
    }
}
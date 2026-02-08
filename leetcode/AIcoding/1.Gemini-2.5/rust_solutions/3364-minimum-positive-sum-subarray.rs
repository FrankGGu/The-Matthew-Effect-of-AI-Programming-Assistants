use std::collections::BTreeSet;
use std::cmp::min;

impl Solution {
    pub fn min_positive_sum_subarray(nums: Vec<i64>) -> i64 {
        let mut min_positive_sum = i64::MAX;
        let mut prefix_sums_set: BTreeSet<i64> = BTreeSet::new();
        prefix_sums_set.insert(0);

        let mut current_sum: i64 = 0;

        for x in nums {
            current_sum += x;

            if let Some(&prev_sum) = prefix_sums_set.range(..current_sum).rev().next() {
                min_positive_sum = min(min_positive_sum, current_sum - prev_sum);
            }

            prefix_sums_set.insert(current_sum);
        }

        min_positive_sum
    }
}
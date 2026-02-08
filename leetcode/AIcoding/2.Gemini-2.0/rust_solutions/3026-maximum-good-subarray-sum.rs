use std::collections::HashMap;

impl Solution {
    pub fn maximum_good_subarray_sum(nums: Vec<i32>, k: i32) -> i64 {
        let mut prefix_sum = 0;
        let mut min_prefix_sum = HashMap::new();
        let mut max_sum = i64::min_value();

        for &num in &nums {
            prefix_sum += num as i64;

            if min_prefix_sum.contains_key(&(prefix_sum - k as i64)) {
                max_sum = max_sum.max(prefix_sum - min_prefix_sum.get(&(prefix_sum - k as i64)).unwrap());
            }
            if min_prefix_sum.contains_key(&(prefix_sum + k as i64)) {
                max_sum = max_sum.max(prefix_sum - min_prefix_sum.get(&(prefix_sum + k as i64)).unwrap());
            }

            min_prefix_sum.entry(prefix_sum).or_insert(i64::max_value());
            *min_prefix_sum.get_mut(&prefix_sum).unwrap() = min_prefix_sum.get(&prefix_sum).unwrap().min(prefix_sum);
        }

        if max_sum == i64::min_value() {
            return 0;
        }

        max_sum
    }
}
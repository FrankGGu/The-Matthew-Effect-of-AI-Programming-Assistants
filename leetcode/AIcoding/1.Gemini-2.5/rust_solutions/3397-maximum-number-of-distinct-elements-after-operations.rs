use std::collections::HashMap;

impl Solution {
    pub fn maximum_distinct_elements_after_operations(nums: Vec<i32>, k: i32) -> i32 {
        let mut counts: HashMap<i32, i32> = HashMap::new();
        for &num in &nums {
            *counts.entry(num).or_insert(0) += 1;
        }

        let mut initial_distinct_count = 0;
        let mut total_duplicates_to_convert = 0;

        for (&_num, &count) in &counts {
            initial_distinct_count += 1;
            if count > 1 {
                total_duplicates_to_convert += count - 1;
            }
        }

        let additional_distinct_elements = std::cmp::min(k, total_duplicates_to_convert);

        initial_distinct_count + additional_distinct_elements
    }
}
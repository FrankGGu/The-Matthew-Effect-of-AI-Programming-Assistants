use std::collections::HashSet;

impl Solution {
    pub fn sum_distinct_elements_squares(nums: Vec<i32>) -> i64 {
        let n = nums.len();
        let mut total_sum_of_squares: i64 = 0;

        for i in 0..n {
            let mut distinct_elements_in_current_subarray_prefix = HashSet::new();
            for j in i..n {
                distinct_elements_in_current_subarray_prefix.insert(nums[j]);

                let mut current_subarray_sum_sq: i64 = 0;
                for &element in &distinct_elements_in_current_subarray_prefix {
                    current_subarray_sum_sq += (element as i64) * (element as i64);
                }
                total_sum_of_squares += current_subarray_sum_sq;
            }
        }
        total_sum_of_squares
    }
}
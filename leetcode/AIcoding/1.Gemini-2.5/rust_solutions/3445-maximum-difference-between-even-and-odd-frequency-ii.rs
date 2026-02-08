use std::cmp;

impl Solution {
    pub fn max_absolute_sum_of_even_odd_diff(nums: Vec<i32>) -> i32 {
        if nums.is_empty() {
            return 0;
        }

        let mut values: Vec<i32> = Vec::with_capacity(nums.len());
        for &num in nums.iter() {
            if num % 2 == 0 {
                values.push(1);
            } else {
                values.push(-1);
            }
        }

        let mut max_sum = values[0];
        let mut current_max_sum = values[0];
        for i in 1..values.len() {
            current_max_sum = cmp::max(values[i], current_max_sum + values[i]);
            max_sum = cmp::max(max_sum, current_max_sum);
        }

        let mut min_sum = values[0];
        let mut current_min_sum = values[0];
        for i in 1..values.len() {
            current_min_sum = cmp::min(values[i], current_min_sum + values[i]);
            min_sum = cmp::min(min_sum, current_min_sum);
        }

        cmp::max(max_sum.abs(), min_sum.abs())
    }
}
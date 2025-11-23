use std::f64;

impl Solution {
    pub fn can_partition_array_into_two_equal_product_subsets(nums: Vec<i32>) -> bool {
        let n = nums.len();
        if n < 2 {
            return false;
        }

        let mut zero_count = 0;
        for &num in &nums {
            if num == 0 {
                zero_count += 1;
            }
        }

        if zero_count == 1 {
            return false;
        }
        if zero_count >= 2 {
            return true;
        }

        // No zeros in the array, proceed with logarithm approach
        let mut total_log_sum = 0.0;
        let mut total_sign = 1;

        for &num in &nums {
            total_log_sum += (num as f64).abs().ln();
            if num < 0 {
                total_sign *= -1;
            }
        }

        let mut left_log_sum = 0.0;
        let mut left_sign = 1;
        const EPSILON: f64 = 1e-9; // Tolerance for floating point comparisons

        for i in 0..n - 1 {
            let current_num = nums[i];
            left_log_sum += (current_num as f64).abs().ln();
            if current_num < 0 {
                left_sign *= -1;
            }

            let right_log_sum = total_log_sum - left_log_sum;
            // left_sign is always 1 or -1, so division is safe and effectively (total_sign * left_sign)
            let right_sign = total_sign / left_sign; 

            if left_sign == right_sign && (left_log_sum - right_log_sum).abs() < EPSILON {
                return true;
            }
        }

        false
    }
}
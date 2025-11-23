impl Solution {

use std::cmp;

impl Solution {
    pub fn maximum_value_between_indices(n: i32, index: i32, max_sum: i32) -> i32 {
        let n = n as usize;
        let index = index as usize;
        let max_sum = max_sum as i64;

        let mut left = 1;
        let mut right = max_sum;

        while left < right {
            let mid = (left + right + 1) / 2;
            if Self::is_possible(n, index, mid, max_sum) {
                left = mid;
            } else {
                right = mid - 1;
            }
        }

        left as i32
    }

    fn is_possible(n: usize, index: usize, value: i64, max_sum: i64) -> bool {
        let left = index as i64;
        let right = (n - 1 - index) as i64;

        let left_sum = Self::sum_of_arithmetic_sequence(value - 1, value - 1 - left);
        let right_sum = Self::sum_of_arithmetic_sequence(value - 1, value - 1 - right);

        let total = left_sum + right_sum + value;

        total <= max_sum
    }

    fn sum_of_arithmetic_sequence(a: i64, b: i64) -> i64 {
        if b < 0 {
            return 0;
        }
        let n = a - b + 1;
        n * (a + b) / 2
    }
}

struct Solution {}
}
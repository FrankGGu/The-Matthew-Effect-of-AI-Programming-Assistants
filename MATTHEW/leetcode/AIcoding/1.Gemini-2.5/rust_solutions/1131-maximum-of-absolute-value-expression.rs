use std::cmp::{max, min};

impl Solution {
    pub fn max_abs_val_expr(arr: Vec<i32>) -> i32 {
        let n = arr.len();

        let mut max_val1 = i32::MIN;
        let mut min_val1 = i32::MAX;

        let mut max_val2 = i32::MIN;
        let mut min_val2 = i32::MAX;

        for k in 0..n {
            // Case 1: (arr[i] + i) - (arr[j] + j)
            // We need to find max(arr[k] + k) - min(arr[k] + k)
            let current_val1 = arr[k] + k as i32;
            max_val1 = max(max_val1, current_val1);
            min_val1 = min(min_val1, current_val1);

            // Case 2: (arr[i] - i) - (arr[j] - j)
            // We need to find max(arr[k] - k) - min(arr[k] - k)
            let current_val2 = arr[k] - k as i32;
            max_val2 = max(max_val2, current_val2);
            min_val2 = min(min_val2, current_val2);
        }

        max(max_val1 - min_val1, max_val2 - min_val2)
    }
}
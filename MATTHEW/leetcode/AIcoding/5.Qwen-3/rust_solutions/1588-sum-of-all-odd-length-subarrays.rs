impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn sum_odd_length_subarrays(mut arr: Vec<i32>) -> i32 {
        let n = arr.len();
        let mut result = 0;

        for i in 0..n {
            let count = ((i + 1) * (n - i) + 1) / 2;
            result += arr[i] * count as i32;
        }

        result
    }
}
}
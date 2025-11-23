use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn maximize_sum_of_squares(nums: Vec<i32>, k: i32) -> i64 {
        let mut min_heap = BinaryHeap::new();

        for &num in &nums {
            min_heap.push(Reverse(num));
        }

        for _ in 0..k {
            let Reverse(x_val) = min_heap.pop().unwrap();

            // Calculate ceil(x_val / 3.0) using integer division
            // For positive integers a, b, ceil(a/b) = (a + b - 1) / b
            // Here b = 3, so (x_val + 3 - 1) / 3 = (x_val + 2) / 3
            // This also works for x_val = 0: (0 + 2) / 3 = 0
            let new_x = (x_val + 2) / 3;

            min_heap.push(Reverse(new_x));
        }

        let mut total_sum_of_squares: i64 = 0;
        while let Some(Reverse(num)) = min_heap.pop() {
            total_sum_of_squares += (num as i64) * (num as i64);
        }

        total_sum_of_squares
    }
}
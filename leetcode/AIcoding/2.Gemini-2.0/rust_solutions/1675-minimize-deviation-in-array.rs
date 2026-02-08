use std::cmp::{max, min};
use std::collections::BinaryHeap;

impl Solution {
    pub fn minimum_deviation(nums: Vec<i32>) -> i32 {
        let mut max_heap = BinaryHeap::new();
        let mut min_val = i32::MAX;

        for &num in &nums {
            let val = if num % 2 == 0 { num } else { num * 2 };
            max_heap.push(val);
            min_val = min(min_val, val);
        }

        let mut deviation = i32::MAX;
        while let Some(max_val) = max_heap.pop() {
            deviation = min(deviation, max_val - min_val);
            if max_val % 2 == 0 {
                max_heap.push(max_val / 2);
                min_val = min(min_val, max_val / 2);
            } else {
                break;
            }
        }

        deviation
    }
}
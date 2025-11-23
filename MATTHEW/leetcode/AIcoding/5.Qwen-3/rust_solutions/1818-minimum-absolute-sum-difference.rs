impl Solution {

use std::collections::BinaryHeap;

struct Solution;

impl Solution {
    pub fn min_absolute_sum_difference(nums: Vec<i32>, target: i32) -> i32 {
        let mut sorted = nums.clone();
        sorted.sort();

        let mut min_diff = i32::MAX;
        let mut total = 0;

        for &num in &nums {
            total += (num - target).abs();
        }

        let mut heap = BinaryHeap::new();

        for &num in &sorted {
            heap.push(num);
        }

        while let Some(num) = heap.pop() {
            let diff = (num - target).abs();
            if diff < min_diff {
                min_diff = diff;
            }
        }

        total - min_diff
    }
}
}
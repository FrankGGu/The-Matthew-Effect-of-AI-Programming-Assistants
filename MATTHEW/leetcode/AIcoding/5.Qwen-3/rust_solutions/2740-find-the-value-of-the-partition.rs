impl Solution {

use std::collections::BinaryHeap;

struct Solution;

impl Solution {
    pub fn get_value_of_partition(nums: Vec<i32>) -> i32 {
        let mut heap = BinaryHeap::new();
        for &num in &nums {
            heap.push(num);
        }
        let mut min_diff = i32::MAX;
        let mut prev = heap.pop().unwrap();
        while let Some(current) = heap.pop() {
            min_diff = std::cmp::min(min_diff, current - prev);
            prev = current;
        }
        min_diff
    }
}
}
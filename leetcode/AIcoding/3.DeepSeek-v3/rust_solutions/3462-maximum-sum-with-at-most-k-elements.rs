use std::collections::BinaryHeap;

impl Solution {
    pub fn maximize_sum(nums: Vec<i32>, k: i32) -> i32 {
        let mut heap = BinaryHeap::from(nums);
        let mut sum = 0;
        for _ in 0..k {
            if let Some(max) = heap.pop() {
                sum += max;
                heap.push(max + 1);
            }
        }
        sum
    }
}
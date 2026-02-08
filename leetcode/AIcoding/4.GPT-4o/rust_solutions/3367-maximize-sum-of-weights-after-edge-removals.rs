use std::collections::BinaryHeap;

impl Solution {
    pub fn maximize_sum(nums: Vec<i32>, remove: i32) -> i32 {
        let mut heap = BinaryHeap::new();
        let mut sum = 0;

        for &num in &nums {
            heap.push(num);
        }

        for _ in 0..remove {
            if let Some(max) = heap.pop() {
                sum += max;
            }
        }

        let mut total = 0;
        while let Some(max) = heap.pop() {
            total += max;
        }

        total - sum
    }
}
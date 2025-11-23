impl Solution {

use std::collections::BinaryHeap;

impl Solution {
    pub fn max_sum_subarray(nums: Vec<i32>, k: i32) -> i32 {
        let k = k as usize;
        let mut max_sum = 0;
        let mut heap = BinaryHeap::new();

        for &num in &nums {
            heap.push(num);
        }

        for _ in 0..k {
            if let Some(val) = heap.pop() {
                max_sum += val;
            }
        }

        max_sum
    }
}
}
impl Solution {

use std::collections::BinaryHeap;

impl Solution {
    pub fn maximum_sum_after_k_operations(nums: Vec<i32>, k: i32) -> i32 {
        let mut max_heap = BinaryHeap::new();
        for num in nums {
            max_heap.push(num);
        }

        for _ in 0..k {
            if let Some(mut val) = max_heap.pop() {
                val += 1;
                max_heap.push(val);
            }
        }

        max_heap.iter().sum()
    }
}
}
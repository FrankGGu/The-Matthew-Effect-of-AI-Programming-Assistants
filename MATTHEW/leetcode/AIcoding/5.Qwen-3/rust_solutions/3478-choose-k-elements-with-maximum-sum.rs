impl Solution {

use std::collections::BinaryHeap;

impl Solution {
    pub fn maximum_sum_k(mut nums: Vec<i32>, k: i32) -> i32 {
        let mut max_heap = BinaryHeap::new();
        for num in nums {
            max_heap.push(num);
        }

        let mut sum = 0;
        for _ in 0..k {
            if let Some(val) = max_heap.pop() {
                sum += val;
            }
        }

        sum
    }
}
}
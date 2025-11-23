impl Solution {

use std::collections::BinaryHeap;

impl Solution {
    pub fn largest_sum_after_k_negations(mut nums: Vec<i32>, k: i32) -> i32 {
        let mut heap = BinaryHeap::new();
        for num in &nums {
            heap.push(std::cmp::Reverse(*num));
        }

        for _ in 0..k {
            if let Some(std::cmp::Reverse(mut val)) = heap.pop() {
                val *= -1;
                heap.push(std::cmp::Reverse(val));
            }
        }

        let mut sum = 0;
        while let Some(std::cmp::Reverse(val)) = heap.pop() {
            sum += val;
        }

        sum
    }
}
}
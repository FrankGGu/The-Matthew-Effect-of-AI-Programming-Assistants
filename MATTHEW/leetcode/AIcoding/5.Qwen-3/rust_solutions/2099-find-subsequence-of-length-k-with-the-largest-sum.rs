impl Solution {

use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn max_subsequence_sum(nums: Vec<i32>, k: i32) -> Vec<i32> {
        let k = k as usize;
        let mut heap = BinaryHeap::new();

        for (i, &num) in nums.iter().enumerate() {
            heap.push(Reverse((num, i)));
            if heap.len() > k {
                heap.pop();
            }
        }

        let mut result = Vec::new();
        while let Some(Reverse((val, idx))) = heap.pop() {
            result.push(val);
        }

        result.sort_by(|a, b| b.cmp(a));
        result
    }
}
}
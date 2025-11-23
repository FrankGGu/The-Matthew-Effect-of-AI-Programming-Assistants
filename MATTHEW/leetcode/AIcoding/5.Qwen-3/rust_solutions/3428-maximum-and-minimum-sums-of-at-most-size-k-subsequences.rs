impl Solution {

use std::cmp::Reverse;
use std::collections::BinaryHeap;

impl Solution {
    pub fn max_subsequence_sum(nums: Vec<i32>, k: i32) -> i32 {
        let k = k as usize;
        let mut max_heap = BinaryHeap::new();
        for (i, &num) in nums.iter().enumerate() {
            max_heap.push(Reverse((num, i)));
        }

        let mut selected = Vec::new();
        while selected.len() < k {
            if let Some(Reverse((val, idx))) = max_heap.pop() {
                selected.push((val, idx));
            }
        }

        selected.sort_by_key(|&(_, idx)| idx);
        let sum: i32 = selected.iter().map(|&(val, _)| val).sum();
        sum
    }
}
}
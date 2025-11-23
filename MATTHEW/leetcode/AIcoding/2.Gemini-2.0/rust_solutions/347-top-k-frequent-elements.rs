use std::collections::HashMap;
use std::collections::BinaryHeap;

impl Solution {
    pub fn top_k_frequent(nums: Vec<i32>, k: i32) -> Vec<i32> {
        let mut counts: HashMap<i32, i32> = HashMap::new();
        for &num in &nums {
            *counts.entry(num).or_insert(0) += 1;
        }

        let mut heap: BinaryHeap<(i32, i32)> = BinaryHeap::new();
        for (&num, &count) in &counts {
            heap.push((-count, num));
        }

        let mut result: Vec<i32> = Vec::new();
        for _ in 0..k {
            if let Some((_, num)) = heap.pop() {
                result.push(num);
            }
        }

        result
    }
}
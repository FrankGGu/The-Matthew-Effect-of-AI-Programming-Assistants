impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn top_k_frequent(nums: Vec<i32>, k: i32) -> Vec<i32> {
        let mut freq = HashMap::new();
        for num in nums {
            *freq.entry(num).or_insert(0) += 1;
        }

        let mut heap = std::collections::BinaryHeap::new();
        for (num, count) in freq {
            heap.push((count, num));
        }

        let mut result = Vec::new();
        for _ in 0..k {
            if let Some((_, num)) = heap.pop() {
                result.push(num);
            }
        }

        result
    }
}
}
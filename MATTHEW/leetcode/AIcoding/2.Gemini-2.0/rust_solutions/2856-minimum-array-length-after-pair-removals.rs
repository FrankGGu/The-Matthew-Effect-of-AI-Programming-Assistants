use std::collections::BinaryHeap;

impl Solution {
    pub fn min_array_length(nums: Vec<i32>) -> i32 {
        let mut counts = std::collections::HashMap::new();
        for &num in &nums {
            *counts.entry(num).or_insert(0) += 1;
        }

        let mut heap = BinaryHeap::new();
        for &count in counts.values() {
            heap.push(count);
        }

        while heap.len() > 1 {
            let a = heap.pop().unwrap();
            let b = heap.pop().unwrap();
            if a > 1 {
                heap.push(a - 1);
            }
            if b > 1 {
                heap.push(b - 1);
            }
        }

        if heap.is_empty() {
            0
        } else {
            heap.pop().unwrap()
        }
    }
}
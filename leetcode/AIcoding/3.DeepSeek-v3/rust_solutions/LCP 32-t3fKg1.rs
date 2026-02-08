use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn batch_processing(tasks: Vec<i32>, batch_size: i32) -> Vec<i32> {
        let mut heap = BinaryHeap::new();
        for &task in &tasks {
            heap.push(Reverse(task));
        }

        let mut result = Vec::new();
        while !heap.is_empty() {
            let mut current_batch = Vec::new();
            for _ in 0..batch_size {
                if let Some(Reverse(task)) = heap.pop() {
                    current_batch.push(task);
                } else {
                    break;
                }
            }
            let max_in_batch = *current_batch.iter().max().unwrap_or(&0);
            result.push(max_in_batch);
            for task in current_batch {
                if task > 1 {
                    heap.push(Reverse(task - 1));
                }
            }
        }
        result
    }
}
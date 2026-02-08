use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn get_order(tasks: Vec<Vec<i32>>) -> Vec<i32> {
        let n = tasks.len();
        let mut indexed_tasks: Vec<(i32, i32, i32)> = tasks.into_iter().enumerate().map(|(i, t)| {
            (t[0], t[1], i as i32)
        }).collect();

        indexed_tasks.sort_unstable_by_key(|t| t.0);

        let mut result: Vec<i32> = Vec::with_capacity(n);
        let mut current_time: i64 = 0;
        let mut task_ptr: usize = 0;
        let mut available_tasks: BinaryHeap<Reverse<(i32, i32)>> = BinaryHeap::new();

        while result.len() < n {
            while task_ptr < n && indexed_tasks[task_ptr].0 as i64 <= current_time {
                available_tasks.push(Reverse((indexed_tasks[task_ptr].1, indexed_tasks[task_ptr].2)));
                task_ptr += 1;
            }

            if let Some(Reverse((processing_time, original_index))) = available_tasks.pop() {
                result.push(original_index);
                current_time += processing_time as i64;
            } else {
                if task_ptr < n {
                    current_time = indexed_tasks[task_ptr].0 as i64;
                }
            }
        }

        result
    }
}
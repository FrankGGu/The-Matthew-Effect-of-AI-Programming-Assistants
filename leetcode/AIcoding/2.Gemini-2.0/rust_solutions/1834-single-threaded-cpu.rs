use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn get_order(tasks: Vec<Vec<i32>>) -> Vec<i32> {
        let n = tasks.len();
        let mut indexed_tasks: Vec<(usize, i32, i32)> = tasks.iter().enumerate().map(|(i, task)| (i, task[0], task[1])).collect();
        indexed_tasks.sort_by_key(|&(_, enqueue_time, _)| enqueue_time);

        let mut heap: BinaryHeap<Reverse<(i32, usize)>> = BinaryHeap::new();
        let mut result: Vec<i32> = Vec::with_capacity(n);
        let mut current_time: i32 = 0;
        let mut task_index: usize = 0;

        while result.len() < n {
            while task_index < n && indexed_tasks[task_index].1 <= current_time {
                heap.push(Reverse((indexed_tasks[task_index].2, indexed_tasks[task_index].0)));
                task_index += 1;
            }

            if heap.is_empty() {
                if task_index < n {
                    current_time = indexed_tasks[task_index].1;
                    while task_index < n && indexed_tasks[task_index].1 <= current_time {
                        heap.push(Reverse((indexed_tasks[task_index].2, indexed_tasks[task_index].0)));
                        task_index += 1;
                    }
                } else {
                    break;
                }
            }

            if let Some(Reverse((processing_time, index))) = heap.pop() {
                result.push(index as i32);
                current_time += processing_time;
            }
        }

        result
    }
}
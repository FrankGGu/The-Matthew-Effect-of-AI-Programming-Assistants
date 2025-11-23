use std::collections::BinaryHeap;

pub fn get_order(tasks: Vec<Vec<i32>>) -> Vec<i32> {
    let n = tasks.len();
    let mut indexed_tasks: Vec<(i32, i32, usize)> = tasks
        .into_iter()
        .enumerate()
        .map(|(i, task)| (task[0], task[1], i))
        .collect();

    indexed_tasks.sort_unstable_by_key(|task| task.0);

    let mut result = Vec::new();
    let mut heap = BinaryHeap::new();
    let mut time = 0;
    let mut i = 0;

    while i < n || !heap.is_empty() {
        if heap.is_empty() {
            time = time.max(indexed_tasks[i].0);
        }

        while i < n && indexed_tasks[i].0 <= time {
            heap.push((-(indexed_tasks[i].1), indexed_tasks[i].2));
            i += 1;
        }

        if let Some((neg_duration, index)) = heap.pop() {
            result.push(index as i32);
            time += -neg_duration;
        }
    }

    result
}
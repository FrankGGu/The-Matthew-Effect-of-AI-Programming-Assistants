use std::collections::BinaryHeap;

impl Solution {
    pub fn max_tasks_assign(tasks: Vec<i32>, workers: Vec<i32>, pills: i32, strength: i32) -> i32 {
        let mut tasks = tasks;
        let mut workers = workers;
        tasks.sort_unstable();
        workers.sort_unstable();

        let n = tasks.len();
        let m = workers.len();

        let mut low = 0;
        let mut high = n.min(m) as i32;
        let mut ans = 0;

        while low <= high {
            let mid = low + (high - low) / 2;
            if mid == 0 { // If 0 tasks can be assigned, it's always possible
                ans = ans.max(mid);
                low = mid + 1;
                continue;
            }

            if Self::check(mid as usize, &tasks, &workers, pills, strength) {
                ans = ans.max(mid);
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }

        ans
    }

    fn check(k: usize, tasks: &[i32], workers: &[i32], mut pills_left: i32, strength: i32) -> bool {
        if k == 0 {
            return true;
        }

        let mut worker_idx = 0;
        // Max-heap to store workers that are too weak for the current task without a pill,
        // but might be able to do it with a pill.
        let mut weak_workers_heap = BinaryHeap::new();

        for task_idx in 0..k {
            let current_task_difficulty = tasks[task_idx];

            // Add all workers that are too weak for the current task (without a pill)
            // but might be useful with a pill, to the heap.
            while worker_idx < workers.len() && workers[worker_idx] < current_task_difficulty {
                weak_workers_heap.push(workers[worker_idx]);
                worker_idx += 1;
            }

            // Option 1: Assign the task to the weakest available worker who can do it directly.
            // This worker is `workers[worker_idx]` if `worker_idx` is valid and `workers[worker_idx]` is strong enough.
            if worker_idx < workers.len() && workers[worker_idx] >= current_task_difficulty {
                // Use this worker directly. It's the weakest available worker that can do it.
                // This saves stronger workers for harder tasks and pills for tasks that truly need them.
                worker_idx += 1;
            }
            // Option 2: No worker can do it directly. Try to use a pill.
            else if !weak_workers_heap.is_empty() && pills_left > 0 {
                // Use a pill on the strongest worker from `weak_workers_heap` that can complete the task.
                // This worker is at the top of the max-heap.
                let strongest_weak_worker = *weak_workers_heap.peek().unwrap();
                if strongest_weak_worker + strength >= current_task_difficulty {
                    weak_workers_heap.pop(); // Use this worker
                    pills_left -= 1;
                } else {
                    // Even the strongest weak worker in the heap can't do it with a pill.
                    return false;
                }
            }
            // Option 3: Cannot assign the current task.
            else {
                return false;
            }
        }

        true
    }
}
use std::collections::BinaryHeap;

impl Solution {
    pub fn max_task_assign(tasks: Vec<i32>, workers: Vec<i32>, pills: i32) -> i32 {
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
            if mid == 0 {
                ans = ans.max(mid);
                low = mid + 1;
                continue;
            }
            if Self::check(mid as usize, &tasks, &workers, pills) {
                ans = ans.max(mid);
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        ans
    }

    // Checks if it's possible to assign `k` tasks.
    // k: number of tasks to assign
    // tasks: sorted task difficulties
    // workers: sorted worker strengths
    // pills: number of pills available
    fn check(k: usize, tasks: &[i32], workers: &[i32], mut pills_remaining: i32) -> bool {
        let mut worker_idx = 0; // Pointer to the weakest available worker
        let mut available_weak_workers: BinaryHeap<i32> = BinaryHeap::new(); // Max-heap for workers too weak for current task

        // Iterate through the k easiest tasks
        for task_idx in 0..k {
            let current_task_difficulty = tasks[task_idx];

            // Add all workers who are too weak for `current_task_difficulty` without a pill
            // to `available_weak_workers`.
            while worker_idx < workers.len() && workers[worker_idx] < current_task_difficulty {
                available_weak_workers.push(workers[worker_idx]);
                worker_idx += 1;
            }

            // Now, `worker_idx` points to the first worker who is strong enough for `current_task_difficulty` (or beyond `workers.len()`).
            // `available_weak_workers` contains workers who are too weak for `current_task_difficulty` without a pill.

            // Decision for `current_task_difficulty`:
            if worker_idx < workers.len() {
                // There is a worker `workers[worker_idx]` strong enough without a pill.
                // We have two options:
                // 1. Assign `current_task_difficulty` to `workers[worker_idx]` (the weakest possible strong worker).
                // 2. If we have pills and `available_weak_workers` is not empty, use a pill on the strongest worker from `available_weak_workers`.
                //    This saves `workers[worker_idx]` for a potentially harder task.
                if pills_remaining > 0
                    && !available_weak_workers.is_empty()
                    && available_weak_workers.peek().unwrap() > &workers[worker_idx]
                {
                    // It's better to use a pill on the strongest weak worker (who is stronger than `workers[worker_idx]`)
                    // and save `workers[worker_idx]` for a task that might require a stronger "natural" worker.
                    available_weak_workers.pop();
                    pills_remaining -= 1;
                } else {
                    // Otherwise, assign `current_task_difficulty` to `workers[worker_idx]` without a pill.
                    worker_idx += 1;
                }
            } else {
                // No worker strong enough without a pill.
                // We must use a pill if available.
                if pills_remaining > 0 && !available_weak_workers.is_empty() {
                    available_weak_workers.pop(); // Use pill on the strongest weak worker.
                    pills_remaining -= 1;
                } else {
                    // Cannot assign this task.
                    return false;
                }
            }
        }
        true
    }
}
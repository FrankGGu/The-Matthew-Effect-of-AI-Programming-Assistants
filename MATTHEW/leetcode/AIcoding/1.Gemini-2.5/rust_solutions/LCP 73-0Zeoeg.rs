use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn max_task_assign(tasks: Vec<i32>, workers: Vec<i32>, pills: i32, strength: i32) -> i32 {
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

            if Self::check(mid as usize, &tasks, &workers, pills, strength) {
                ans = ans.max(mid);
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        ans
    }

    fn check(k: usize, tasks: &[i32], workers: &[i32], mut pills: i32, strength: i32) -> bool {
        let mut worker_ptr = 0;
        let mut available_workers: BinaryHeap<Reverse<i32>> = BinaryHeap::new();

        for i in 0..k { // Iterate through the k easiest tasks
            let current_task = tasks[i];

            // Add all workers (from `worker_ptr` onwards) who can do `current_task` with a pill.
            // Condition: worker_ability + strength >= current_task
            while worker_ptr < workers.len() && workers[worker_ptr] + strength >= current_task {
                available_workers.push(Reverse(workers[worker_ptr]));
                worker_ptr += 1;
            }

            // If no workers are available for `current_task`, then k tasks cannot be assigned.
            if available_workers.is_empty() {
                return false;
            }

            // The weakest worker in `available_workers` is `available_workers.peek().unwrap().0`.
            // If this weakest worker can do `current_task` without a pill:
            if available_workers.peek().unwrap().0 >= current_task {
                // Use this weakest worker. This saves a pill.
                available_workers.pop();
            } else if pills > 0 {
                // The weakest worker needs a pill. Use them with a pill.
                available_workers.pop();
                pills -= 1;
            } else {
                // Cannot assign `current_task` (no worker strong enough without pill, and no pills left).
                return false;
            }
        }
        true
    }
}
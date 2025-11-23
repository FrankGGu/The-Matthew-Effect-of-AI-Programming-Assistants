use std::collections::VecDeque;

impl Solution {
    pub fn max_task_assign(mut tasks: Vec<i32>, mut workers: Vec<i32>, pills: i32, strength: i32) -> i32 {
        tasks.sort();
        workers.sort();
        let mut left = 0;
        let mut right = std::cmp::min(tasks.len(), workers.len()) as i32;
        let mut answer = 0;

        while left <= right {
            let mid = left + (right - left) / 2;
            if Self::can_assign(&tasks, &workers, pills, strength, mid) {
                answer = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        answer
    }

    fn can_assign(tasks: &[i32], workers: &[i32], pills: i32, strength: i32, k: i32) -> bool {
        let k = k as usize;
        if k > workers.len() {
            return false;
        }

        let mut tasks_deque = VecDeque::new();
        let mut pills_used = 0;
        let mut worker_ptr = workers.len() - k;

        for i in (0..k).rev() {
            let task = tasks[i];
            while worker_ptr < workers.len() {
                let worker = workers[worker_ptr];
                if worker >= task {
                    worker_ptr += 1;
                    break;
                } else if worker + strength >= task {
                    if tasks_deque.is_empty() {
                        tasks_deque.push_back(worker);
                        worker_ptr += 1;
                        break;
                    } else {
                        let weakest = tasks_deque.pop_front().unwrap();
                        if weakest >= task {
                            tasks_deque.push_front(weakest);
                            tasks_deque.push_back(worker);
                            worker_ptr += 1;
                            break;
                        } else {
                            pills_used += 1;
                            if pills_used > pills {
                                return false;
                            }
                        }
                    }
                } else {
                    if tasks_deque.is_empty() {
                        return false;
                    } else {
                        let weakest = tasks_deque.pop_front().unwrap();
                        if weakest >= task {
                            tasks_deque.push_front(weakest);
                            return false;
                        } else {
                            pills_used += 1;
                            if pills_used > pills {
                                return false;
                            }
                        }
                    }
                }
            }
        }

        true
    }
}
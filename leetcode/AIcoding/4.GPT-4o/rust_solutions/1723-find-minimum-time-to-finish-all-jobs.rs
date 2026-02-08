pub fn minimum_time_required(jobs: Vec<i32>, k: i32) -> i32 {
    let mut left = *jobs.iter().max().unwrap();
    let mut right = jobs.iter().sum::<i32>();

    while left < right {
        let mid = left + (right - left) / 2;
        if can_finish(&jobs, k, mid) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }

    left
}

fn can_finish(jobs: &[i32], k: i32, max_time: i32) -> bool {
    let mut workers = vec![0; k as usize];
    can_assign(0, jobs, &mut workers, max_time)
}

fn can_assign(index: usize, jobs: &[i32], workers: &mut Vec<i32>, max_time: i32) -> bool {
    if index == jobs.len() {
        return true;
    }

    for i in 0..workers.len() {
        if workers[i] + jobs[index] <= max_time {
            workers[i] += jobs[index];
            if can_assign(index + 1, jobs, workers, max_time) {
                return true;
            }
            workers[i] -= jobs[index];
        }
        if workers[i] == 0 {
            break;
        }
    }

    false
}
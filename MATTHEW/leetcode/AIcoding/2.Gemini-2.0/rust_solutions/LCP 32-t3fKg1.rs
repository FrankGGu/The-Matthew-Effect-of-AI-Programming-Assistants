impl Solution {
    pub fn get_max_task_assign(tasks: Vec<i32>, workers: Vec<i32>, pills: i32, strength: i32) -> i32 {
        let mut tasks = tasks;
        let mut workers = workers;
        tasks.sort();
        workers.sort();

        let mut left = 0;
        let mut right = tasks.len();

        while left < right {
            let mid = (left + right + 1) / 2;
            if Solution::can_assign(&tasks[..mid], &workers, pills, strength) {
                left = mid;
            } else {
                right = mid - 1;
            }
        }

        left as i32
    }

    fn can_assign(tasks: &[i32], workers: &[i32], pills: i32, strength: i32) -> bool {
        let mut workers = workers.to_vec();
        workers.sort_by(|a, b| b.cmp(a));
        let mut tasks = tasks.to_vec();
        tasks.sort_by(|a, b| b.cmp(a));

        let mut j = workers.len() - 1;
        let mut pills_used = 0;

        for i in 0..tasks.len() {
            if workers[j] >= tasks[i] {
                j -= 1;
            } else if pills_used < pills && tasks[i] - strength <= workers[0] {
                pills_used += 1;
            } else {
                return false;
            }
        }

        true
    }
}
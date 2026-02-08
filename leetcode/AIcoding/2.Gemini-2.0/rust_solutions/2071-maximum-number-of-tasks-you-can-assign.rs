impl Solution {
    pub fn max_tasks(tasks: Vec<i32>, workers: Vec<i32>, pills: i32, strength: i32) -> i32 {
        let mut tasks = tasks;
        let mut workers = workers;
        tasks.sort();
        workers.sort();

        let n = tasks.len();
        let m = workers.len();

        let mut l = 0;
        let mut r = std::cmp::min(n, m) as i32;

        while l <= r {
            let mid = l + (r - l) / 2;
            if Solution::can_assign(&tasks, &workers, pills, strength, mid as usize) {
                l = mid + 1;
            } else {
                r = mid - 1;
            }
        }

        r
    }

    fn can_assign(tasks: &Vec<i32>, workers: &Vec<i32>, pills: i32, strength: i32, k: usize) -> bool {
        let mut workers = workers[workers.len() - k..].to_vec();
        workers.sort();

        let mut pills_used = 0;
        let mut j = k;
        for i in (0..k).rev() {
            j -= 1;
            if workers[i] >= tasks[tasks.len() - 1 - j] {
                continue;
            } else {
                if pills_used < pills && tasks[tasks.len() - 1 - j] - strength <= workers[i] {
                    pills_used += 1;
                } else {
                    return false;
                }
            }
        }

        true
    }
}
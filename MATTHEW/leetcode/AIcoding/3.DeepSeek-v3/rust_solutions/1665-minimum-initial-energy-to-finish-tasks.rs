impl Solution {
    pub fn minimum_effort(tasks: Vec<Vec<i32>>) -> i32 {
        let mut tasks = tasks;
        tasks.sort_by(|a, b| (b[1] - b[0]).cmp(&(a[1] - a[0])));

        let mut res = 0;
        let mut curr = 0;

        for task in tasks {
            if curr < task[1] {
                res += task[1] - curr;
                curr = task[1];
            }
            curr -= task[0];
        }

        res
    }
}
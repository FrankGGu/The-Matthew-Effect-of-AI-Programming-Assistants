impl Solution {
    pub fn find_minimum_time(tasks: Vec<Vec<i32>>) -> i32 {
        let mut tasks = tasks;
        tasks.sort_by(|a, b| a[1].cmp(&b[1]));
        let mut used = vec![false; 2001];
        let mut res = 0;
        for task in tasks {
            let start = task[0] as usize;
            let end = task[1] as usize;
            let mut duration = task[2];
            for t in start..=end {
                if used[t] {
                    duration -= 1;
                }
            }
            let mut t = end;
            while duration > 0 && t >= start {
                if !used[t] {
                    used[t] = true;
                    duration -= 1;
                    res += 1;
                }
                t -= 1;
            }
        }
        res
    }
}
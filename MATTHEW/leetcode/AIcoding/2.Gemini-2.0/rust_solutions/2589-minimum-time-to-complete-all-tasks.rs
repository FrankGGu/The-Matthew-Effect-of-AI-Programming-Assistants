impl Solution {
    pub fn minimum_time(tasks: Vec<Vec<i32>>) -> i32 {
        let mut tasks = tasks;
        tasks.sort_by_key(|task| task[1]);

        let mut time = 0;
        let mut active = vec![false; tasks.last().unwrap()[1] as usize + 1];

        for task in tasks {
            let start = task[0] as usize;
            let end = task[1] as usize;
            let duration = task[2];

            let mut count = 0;
            for i in start..=end {
                if active[i] {
                    count += 1;
                }
            }

            let mut need = duration - count;
            for i in (start..=end).rev() {
                if need == 0 {
                    break;
                }
                if !active[i] {
                    active[i] = true;
                    time += 1;
                    need -= 1;
                }
            }
        }

        time
    }
}
impl Solution {
    pub fn exclusive_time(n: i32, logs: Vec<String>) -> Vec<i32> {
        let mut stack: Vec<(i32, i32)> = Vec::new();
        let mut res: Vec<i32> = vec![0; n as usize];
        let mut prev_time = 0;

        for log in logs {
            let parts: Vec<&str> = log.split(':').collect();
            let id = parts[0].parse::<i32>().unwrap();
            let type_ = parts[1];
            let time = parts[2].parse::<i32>().unwrap();

            if type_ == "start" {
                if !stack.is_empty() {
                    let (prev_id, _) = stack.last().unwrap();
                    res[*prev_id as usize] += time - prev_time;
                }
                stack.push((id, time));
                prev_time = time;
            } else {
                let (curr_id, start_time) = stack.pop().unwrap();
                res[curr_id as usize] += time - start_time + 1;
                prev_time = time + 1;
            }
        }

        res
    }
}
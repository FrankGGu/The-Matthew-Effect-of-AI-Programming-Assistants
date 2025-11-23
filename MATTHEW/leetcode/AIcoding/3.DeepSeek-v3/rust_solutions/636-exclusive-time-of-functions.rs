impl Solution {
    pub fn exclusive_time(n: i32, logs: Vec<String>) -> Vec<i32> {
        let mut res = vec![0; n as usize];
        let mut stack = Vec::new();
        let mut prev_time = 0;

        for log in logs {
            let parts: Vec<&str> = log.split(':').collect();
            let id = parts[0].parse::<usize>().unwrap();
            let is_start = parts[1] == "start";
            let time = parts[2].parse::<i32>().unwrap();

            if is_start {
                if let Some(&top_id) = stack.last() {
                    res[top_id] += time - prev_time;
                }
                stack.push(id);
                prev_time = time;
            } else {
                let top_id = stack.pop().unwrap();
                res[top_id] += time - prev_time + 1;
                prev_time = time + 1;
            }
        }

        res
    }
}
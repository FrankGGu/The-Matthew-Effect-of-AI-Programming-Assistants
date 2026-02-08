impl Solution {
    pub fn exclusive_time(n: i32, logs: Vec<String>) -> Vec<i32> {
        let mut ans = vec![0; n as usize];
        let mut stack: Vec<i32> = Vec::new();
        let mut prev_time = 0;

        for log_str in logs {
            let parts: Vec<&str> = log_str.split(':').collect();
            let fn_id = parts[0].parse::<i32>().unwrap();
            let event_type = parts[1];
            let timestamp = parts[2].parse::<i32>().unwrap();

            match event_type {
                "start" => {
                    if let Some(&top_fn_id) = stack.last() {
                        ans[top_fn_id as usize] += timestamp - prev_time;
                    }
                    stack.push(fn_id);
                    prev_time = timestamp;
                }
                "end" => {
                    let popped_fn_id = stack.pop().unwrap();
                    ans[popped_fn_id as usize] += timestamp - prev_time + 1;
                    prev_time = timestamp + 1;
                }
                _ => unreachable!(),
            }
        }

        ans
    }
}
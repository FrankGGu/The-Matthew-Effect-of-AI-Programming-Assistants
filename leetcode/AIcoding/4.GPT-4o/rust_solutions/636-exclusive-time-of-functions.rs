pub fn exclusive_time(n: i32, logs: Vec<String>) -> Vec<i32> {
    let mut result = vec![0; n as usize];
    let mut stack = Vec::new();
    let mut prev_time = 0;

    for log in logs {
        let parts: Vec<&str> = log.split(':').collect();
        let function_id: i32 = parts[0].parse().unwrap();
        let is_start: bool = parts[1] == "start";
        let time: i32 = parts[2].parse().unwrap();

        if !stack.is_empty() {
            result[stack.last().unwrap() as usize] += time - prev_time;
        }
        prev_time = time;

        if is_start {
            stack.push(function_id);
        } else {
            result[stack.pop().unwrap() as usize] += 1;
            prev_time += 1;
        }
    }

    result
}
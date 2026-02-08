impl Solution {
    pub fn count_servers(n: i32, logs: Vec<Vec<i32>>, x: i32, queries: Vec<i32>) -> Vec<i32> {
        let mut result = Vec::new();
        for &q in &queries {
            let mut count = 0;
            for i in 0..n {
                let start_time = q - x;
                let end_time = q;
                let mut served = false;
                for log in &logs {
                    if log[0] == i + 1 && log[1] >= start_time && log[1] <= end_time {
                        served = true;
                        break;
                    }
                }
                if !served {
                    count += 1;
                }
            }
            result.push(count);
        }
        result
    }
}
struct Solution;

impl Solution {
    pub fn count_zero_requests(servers: Vec<i32>, requests: Vec<i32>) -> Vec<i32> {
        let mut result = vec![];
        let mut server_count = std::collections::HashMap::new();

        for &server in &servers {
            *server_count.entry(server).or_insert(0) += 1;
        }

        for &request in &requests {
            if let Some(count) = server_count.get_mut(&request) {
                *count -= 1;
                if *count == 0 {
                    server_count.remove(&request);
                }
            }
            result.push(server_count.len() as i32);
        }

        result
    }
}
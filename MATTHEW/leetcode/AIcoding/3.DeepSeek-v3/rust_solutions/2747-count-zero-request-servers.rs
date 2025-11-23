use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn count_servers(n: i32, logs: Vec<Vec<i32>>, x: i32, queries: Vec<i32>) -> Vec<i32> {
        let n = n as usize;
        let mut logs = logs;
        logs.sort_by_key(|log| log[1]);

        let mut queries_with_indices: Vec<(i32, usize)> = queries.iter().enumerate().map(|(i, &q)| (q, i)).collect();
        queries_with_indices.sort();

        let mut res = vec![0; queries.len()];
        let mut left = 0;
        let mut right = 0;
        let mut server_count = HashMap::new();

        for (query, idx) in queries_with_indices {
            let start = query - x;
            let end = query;

            while right < logs.len() && logs[right][1] <= end {
                let server = logs[right][0];
                *server_count.entry(server).or_insert(0) += 1;
                right += 1;
            }

            while left < logs.len() && logs[left][1] < start {
                let server = logs[left][0];
                *server_count.get_mut(&server).unwrap() -= 1;
                if server_count[&server] == 0 {
                    server_count.remove(&server);
                }
                left += 1;
            }

            res[idx] = (n - server_count.len()) as i32;
        }

        res
    }
}
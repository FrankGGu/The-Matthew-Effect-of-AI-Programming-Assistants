use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn count_zero_request_servers(servers: Vec<Vec<i32>>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        // Step 1: Determine the total number of distinct servers that ever received a request.
        let mut all_server_ids = HashSet::new();
        for server_req in &servers {
            all_server_ids.insert(server_req[0]);
        }
        let total_distinct_servers = all_server_ids.len() as i32;

        // Step 2: Prepare data for efficient processing.
        // Sort server requests by their time.
        let mut servers = servers;
        servers.sort_unstable_by_key(|s| s[1]);

        // Pair queries with their original indices and sort them by query_time.
        let mut indexed_queries: Vec<(i32, i32, usize)> = queries
            .into_iter()
            .enumerate()
            .map(|(i, q)| (q[0], q[1], i))
            .collect();
        indexed_queries.sort_unstable_by_key(|q| q.0); // Sort by query_time

        let mut ans = vec![0; indexed_queries.len()];
        let mut server_counts: HashMap<i32, i32> = HashMap::new();
        let mut distinct_servers_in_window = 0;

        let mut left_ptr = 0; // Pointer for the start of the sliding window in the sorted 'servers' array.
        let mut right_ptr = 0; // Pointer for the end of the sliding window in the sorted 'servers' array (exclusive).

        // Step 3: Process queries using a sliding window approach.
        for (query_time, duration, original_index) in indexed_queries {
            let window_start = query_time - duration;
            let window_end = query_time;

            // Expand the window: Add server requests that fall within or before the current query's 'window_end'.
            while right_ptr < servers.len() && servers[right_ptr][1] <= window_end {
                let server_id = servers[right_ptr][0];
                let count = server_counts.entry(server_id).or_insert(0);
                *count += 1;
                // If this is the first request for this server in the current window, increment distinct_servers_in_window.
                if *count == 1 {
                    distinct_servers_in_window += 1;
                }
                right_ptr += 1;
            }

            // Shrink the window: Remove server requests that fall strictly before the current query's 'window_start'.
            while left_ptr < servers.len() && servers[left_ptr][1] < window_start {
                let server_id = servers[left_ptr][0];
                let count = server_counts.entry(server_id).or_insert(0); // Entry should always exist here.
                *count -= 1;
                // If this was the last request for this server in the current window, decrement distinct_servers_in_window.
                if *count == 0 {
                    distinct_servers_in_window -= 1;
                }
                left_ptr += 1;
            }

            // Calculate the answer for the current query:
            // Total distinct servers minus servers that had at least one request in the window.
            ans[original_index] = total_distinct_servers - distinct_servers_in_window;
        }

        ans
    }
}
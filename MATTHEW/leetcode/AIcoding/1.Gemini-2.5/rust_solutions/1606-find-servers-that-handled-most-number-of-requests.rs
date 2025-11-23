use std::collections::{BinaryHeap, BTreeSet};
use std::cmp::Reverse;

impl Solution {
    pub fn busiest_servers(k: i32, arrival_time: Vec<i32>, load: Vec<i32>) -> Vec<i32> {
        let k_usize = k as usize;
        let n = arrival_time.len();

        let mut server_counts = vec![0; k_usize];

        // busy_servers stores (finish_time, server_id) for servers that are currently busy.
        // It's a min-heap based on finish_time, so we use Reverse for BinaryHeap.
        let mut busy_servers: BinaryHeap<Reverse<(i32, usize)>> = BinaryHeap::new();

        // available_servers stores the IDs of servers that are currently free.
        // BTreeSet keeps them sorted, allowing efficient range queries.
        let mut available_servers: BTreeSet<usize> = (0..k_usize).collect();

        for i in 0..n {
            let current_time = arrival_time[i];
            let duration = load[i];

            // Free up servers whose tasks have finished by the current request's arrival time.
            while let Some(Reverse((finish_time, server_id))) = busy_servers.peek() {
                if *finish_time <= current_time {
                    let Reverse((_, server_id)) = busy_servers.pop().unwrap();
                    available_servers.insert(server_id);
                } else {
                    break; 
                }
            }

            // Determine the preferred starting server for this request.
            let start_server_idx = i % k_usize;
            let mut target_server_id: Option<usize> = None;

            // Search for an available server starting from start_server_idx.
            // First, check servers with IDs >= start_server_idx.
            if let Some(&server_id) = available_servers.range(start_server_idx..).next() {
                target_server_id = Some(server_id);
            } else {
                // If no server found in the first range, wrap around and check servers with IDs < start_server_idx.
                if let Some(&server_id) = available_servers.range(0..).next() {
                    target_server_id = Some(server_id);
                }
            }

            // If an available server is found, assign the request to it.
            if let Some(server_id) = target_server_id {
                available_servers.remove(&server_id);
                server_counts[server_id] += 1;
                busy_servers.push(Reverse((current_time + duration, server_id)));
            }
            // If no server is found, the request is dropped.
        }

        // Find the maximum number of requests handled by any server.
        let mut max_requests = 0;
        for &count in &server_counts {
            if count > max_requests {
                max_requests = count;
            }
        }

        // Collect all server IDs that handled the maximum number of requests.
        let mut busiest_servers_list = Vec::new();
        for (server_id, &count) in server_counts.iter().enumerate() {
            if count == max_requests {
                busiest_servers_list.push(server_id as i32);
            }
        }

        busiest_servers_list
    }
}
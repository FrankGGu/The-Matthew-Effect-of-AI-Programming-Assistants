use std::collections::VecDeque;

impl Solution {
    pub fn network_idle_time(edges: Vec<Vec<i32>>, patience: Vec<i32>) -> i32 {
        let n = patience.len();

        let mut adj: Vec<Vec<usize>> = vec![vec![]; n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut dist: Vec<i32> = vec![-1; n];
        let mut queue: VecDeque<usize> = VecDeque::new();

        dist[0] = 0;
        queue.push_back(0);

        while let Some(u) = queue.pop_front() {
            for &v in &adj[u] {
                if dist[v] == -1 {
                    dist[v] = dist[u] + 1;
                    queue.push_back(v);
                }
            }
        }

        let mut max_idle_time = 0;

        for i in 1..n {
            let d = dist[i];
            let p = patience[i];

            let last_packet_arrival_time_at_0: i32;

            if p == 0 {
                last_packet_arrival_time_at_0 = 2 * d;
            } else {
                // The reply from server 0 reaches server i at time 2*d.
                // Server i sends its first packet at time d.
                // It resends every p seconds until it receives its reply.
                // So, the last packet must be sent at time T_send < 2*d.
                // The send times are d, d+p, d+2p, ... , d+k*p.
                // We need the largest k such that d + k*p < 2*d.
                // This simplifies to k*p < d, or k < d/p.
                // Using integer division, k_max = (d - 1) / p (for d >= 1).
                let num_resends_intervals = (d - 1) / p;
                let last_send_time_from_i = d + num_resends_intervals * p;

                // This last packet travels back to server 0, taking 'd' seconds.
                last_packet_arrival_time_at_0 = last_send_time_from_i + d;
            }

            max_idle_time = max_idle_time.max(last_packet_arrival_time_at_0);
        }

        max_idle_time + 1
    }
}
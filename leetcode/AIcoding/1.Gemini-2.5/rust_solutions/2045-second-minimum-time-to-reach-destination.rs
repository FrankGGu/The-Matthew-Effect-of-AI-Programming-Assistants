use std::collections::VecDeque;

struct Solution;

impl Solution {
    pub fn second_minimum(n: i32, edges: Vec<Vec<i32>>, time: i32, change: i32) -> i32 {
        let n_usize = n as usize;
        let travel_time = time as i64;
        let change_interval = change as i64;

        let mut adj: Vec<Vec<usize>> = vec![vec![]; n_usize];
        for edge in edges {
            let u = (edge[0] - 1) as usize;
            let v = (edge[1] - 1) as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut min_time: Vec<[i64; 2]> = vec![[i64::MAX, i64::MAX]; n_usize];
        let mut queue: VecDeque<(i64, usize)> = VecDeque::new();

        min_time[0][0] = 0;
        queue.push_back((0, 0));

        while let Some((t, u)) = queue.pop_front() {
            if u == n_usize - 1 && min_time[n_usize - 1][1] != i64::MAX {
                return min_time[n_usize - 1][1] as i32;
            }

            let num_cycles = t / change_interval;
            let depart_time_from_u = if num_cycles % 2 == 0 {
                t
            } else {
                (num_cycles + 1) * change_interval
            };

            for &v in &adj[u] {
                let new_arrival_time_at_v = depart_time_from_u + travel_time;

                if new_arrival_time_at_v < min_time[v][0] {
                    min_time[v][1] = min_time[v][0];
                    min_time[v][0] = new_arrival_time_at_v;
                    queue.push_back((new_arrival_time_at_v, v));
                } else if new_arrival_time_at_v > min_time[v][0] && new_arrival_time_at_v < min_time[v][1] {
                    min_time[v][1] = new_arrival_time_at_v;
                    queue.push_back((new_arrival_time_at_v, v));
                }
            }
        }

        // This line should be reached only if the early exit condition above didn't trigger,
        // which implies the second minimum time for the destination was found but not yet returned.
        min_time[n_usize - 1][1] as i32
    }
}
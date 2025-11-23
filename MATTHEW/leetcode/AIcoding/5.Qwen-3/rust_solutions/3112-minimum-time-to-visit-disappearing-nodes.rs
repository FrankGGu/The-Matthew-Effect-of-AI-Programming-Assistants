impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn min_time_to_visit_disappearing_nodes(n: i32, edges: Vec<Vec<i32>>, start: i32, end: i32, time_limit: i32) -> i32 {
        let n = n as usize;
        let mut graph = vec![vec![]; n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            graph[u].push(v);
            graph[v].push(u);
        }

        let mut time = vec![i32::MAX; n];
        let mut queue = VecDeque::new();
        time[start as usize] = 0;
        queue.push_back(start);

        while let Some(current) = queue.pop_front() {
            let current_idx = current as usize;
            for &neighbor in &graph[current_idx] {
                let new_time = time[current_idx] + 1;
                if new_time < time[neighbor] && new_time <= time_limit {
                    time[neighbor] = new_time;
                    queue.push_back(neighbor as i32);
                }
            }
        }

        if time[end as usize] <= time_limit {
            time[end as usize]
        } else {
            -1
        }
    }
}
}
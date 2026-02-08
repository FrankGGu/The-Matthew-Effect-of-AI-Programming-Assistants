use std::collections::VecDeque;

impl Solution {
    pub fn minimum_time(n: i32, relations: Vec<Vec<i32>>, time: Vec<i32>) -> i32 {
        let n = n as usize;
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n];
        let mut in_degree: Vec<i32> = vec![0; n];
        let mut dp: Vec<i32> = time.clone(); // dp[i] stores the maximum time to finish course i (0-indexed)

        for relation in relations {
            let prev_course = (relation[0] - 1) as usize;
            let next_course = (relation[1] - 1) as usize;
            adj[prev_course].push(next_course);
            in_degree[next_course] += 1;
        }

        let mut q: VecDeque<usize> = VecDeque::new();

        for i in 0..n {
            if in_degree[i] == 0 {
                q.push_back(i);
            }
        }

        while let Some(u) = q.pop_front() {
            for &v in &adj[u] {
                // The time to finish course v is its own time plus the maximum time
                // to finish any of its prerequisites.
                // dp[u] is the time to finish course u, including all its prerequisites.
                // If u is a prerequisite for v, then v can't start until dp[u] time has passed.
                // The total time to finish v, considering u as its bottleneck prerequisite,
                // would be dp[u] + time[v]. We take the maximum of all such paths for v.
                dp[v] = dp[v].max(dp[u] + time[v]);

                in_degree[v] -= 1;
                if in_degree[v] == 0 {
                    q.push_back(v);
                }
            }
        }

        *dp.iter().max().unwrap_or(&0)
    }
}
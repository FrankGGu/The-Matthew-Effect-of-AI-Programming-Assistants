impl Solution {
    pub fn maximum_invitations(favorite: Vec<i32>) -> i32 {
        let n = favorite.len();
        let mut in_degree = vec![0; n];
        for &f in &favorite {
            in_degree[f as usize] += 1;
        }

        let mut q = std::collections::VecDeque::new();
        for i in 0..n {
            if in_degree[i] == 0 {
                q.push_back(i);
            }
        }

        let mut dp = vec![1; n];
        while let Some(u) = q.pop_front() {
            let v = favorite[u] as usize;
            dp[v] = dp[v].max(dp[u] + 1);
            in_degree[v] -= 1;
            if in_degree[v] == 0 {
                q.push_back(v);
            }
        }

        let mut max_cycle = 0;
        let mut sum_chain = 0;

        for i in 0..n {
            if in_degree[i] == 0 {
                continue;
            }
            let mut cycle_len = 0;
            let mut j = i;
            while in_degree[j] != 0 {
                in_degree[j] = 0;
                j = favorite[j] as usize;
                cycle_len += 1;
            }
            if cycle_len == 2 {
                sum_chain += dp[i] + dp[favorite[i] as usize];
            } else {
                max_cycle = max_cycle.max(cycle_len);
            }
        }

        max_cycle.max(sum_chain)
    }
}
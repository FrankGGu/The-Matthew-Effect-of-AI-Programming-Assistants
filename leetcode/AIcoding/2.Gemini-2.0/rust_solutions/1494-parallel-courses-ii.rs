use std::collections::VecDeque;

impl Solution {
    pub fn min_number_of_semesters(n: i32, dependencies: Vec<Vec<i32>>, k: i32) -> i32 {
        let n = n as usize;
        let mut in_degree = vec![0; n];
        let mut adj = vec![vec![]; n];
        let mut pre_mask = vec![0; n];

        for dep in &dependencies {
            let u = (dep[0] - 1) as usize;
            let v = (dep[1] - 1) as usize;
            adj[u].push(v);
            in_degree[v] += 1;
            pre_mask[v] |= 1 << u;
        }

        let mut dp = vec![std::i32::MAX; 1 << n];
        dp[0] = 0;

        for mask in 0..(1 << n) {
            if dp[mask] == std::i32::MAX {
                continue;
            }

            let mut available = vec![];
            for i in 0..n {
                if (mask & (1 << i)) == 0 && (pre_mask[i] & mask) == pre_mask[i] {
                    available.push(i);
                }
            }

            let m = available.len();
            for sub_mask in 0..(1 << m) {
                if sub_mask.count_ones() as i32 > k {
                    continue;
                }

                let mut next_mask = mask;
                for i in 0..m {
                    if (sub_mask & (1 << i)) != 0 {
                        next_mask |= 1 << available[i];
                    }
                }

                dp[next_mask] = dp[next_mask].min(dp[mask] + 1);
            }
        }

        dp[(1 << n) - 1]
    }
}
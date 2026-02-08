impl Solution {
    pub fn color_the_grid(m: i32, n: i32) -> i32 {
        let m = m as usize;
        let n = n as usize;
        let mut states = Vec::new();
        let mut q = vec![Vec::new()];
        q[0].push(0);
        while let Some(curr) = q.pop() {
            let len = curr.len();
            if len == m {
                states.push(curr);
                continue;
            }
            for i in 1..=3 {
                if len > 0 && curr[len - 1] == i {
                    continue;
                }
                let mut next = curr.clone();
                next.push(i);
                q.push(next);
            }
        }

        let mut adj = vec![Vec::new(); states.len()];
        for i in 0..states.len() {
            for j in 0..states.len() {
                let mut valid = true;
                for k in 0..m {
                    if states[i][k] == states[j][k] {
                        valid = false;
                        break;
                    }
                }
                if valid {
                    adj[i].push(j);
                }
            }
        }

        let mut dp = vec![vec![0; states.len()]; n + 1];
        for i in 0..states.len() {
            dp[1][i] = 1;
        }

        for i in 2..=n {
            for j in 0..states.len() {
                for &k in &adj[j] {
                    dp[i][j] = (dp[i][j] + dp[i - 1][k]) % 1000000007;
                }
            }
        }

        let mut ans = 0;
        for i in 0..states.len() {
            ans = (ans + dp[n][i]) % 1000000007;
        }

        ans
    }
}
impl Solution {
    pub fn minimum_changes(s: String, k: i32) -> i32 {
        let n = s.len();
        let s = s.as_bytes();
        let mut cost = vec![vec![0; n]; n];

        for i in 0..n {
            for j in i + 1..n {
                let len = j - i + 1;
                let mut min_cost = i32::MAX;
                for d in 1..len {
                    if len % d != 0 {
                        continue;
                    }
                    let mut current_cost = 0;
                    for m in 0..d {
                        let mut left = i + m;
                        let mut right = j - (d - 1 - m);
                        while left < right {
                            if s[left] != s[right] {
                                current_cost += 1;
                            }
                            left += d;
                            right -= d;
                        }
                    }
                    if current_cost < min_cost {
                        min_cost = current_cost;
                    }
                }
                cost[i][j] = min_cost;
            }
        }

        let mut dp = vec![vec![i32::MAX; k as usize + 1]; n + 1];
        dp[0][0] = 0;

        for i in 1..=n {
            for j in 1..=k as usize {
                for l in 0..i {
                    if dp[l][j - 1] != i32::MAX && cost[l][i - 1] != i32::MAX {
                        dp[i][j] = dp[i][j].min(dp[l][j - 1] + cost[l][i - 1]);
                    }
                }
            }
        }

        dp[n][k as usize]
    }
}
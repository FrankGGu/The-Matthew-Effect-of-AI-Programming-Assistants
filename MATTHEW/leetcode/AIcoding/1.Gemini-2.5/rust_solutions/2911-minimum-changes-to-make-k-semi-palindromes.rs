impl Solution {
    pub fn minimum_changes(s: String, k: i32) -> i32 {
        let n = s.len();
        let k = k as usize;
        let s_chars: Vec<char> = s.chars().collect();

        let mut cost = vec![vec![0; n]; n];

        for i in 0..n {
            for j in i..n {
                let mut current_cost = 0;
                for p in 0..(j - i) {
                    if p % 2 == 0 {
                        if s_chars[i + p] != s_chars[i + p + 1] {
                            current_cost += 1;
                        }
                    }
                }
                cost[i][j] = current_cost;
            }
        }

        let mut dp = vec![vec![i32::MAX / 2; k + 1]; n + 1];

        dp[0][0] = 0;

        for j in 1..=k {
            for i in 1..=n {
                for p in 0..i {
                    if dp[p][j - 1] != i32::MAX / 2 {
                        let current_segment_cost = cost[p][i - 1];
                        dp[i][j] = dp[i][j].min(dp[p][j - 1] + current_segment_cost);
                    }
                }
            }
        }

        dp[n][k]
    }
}
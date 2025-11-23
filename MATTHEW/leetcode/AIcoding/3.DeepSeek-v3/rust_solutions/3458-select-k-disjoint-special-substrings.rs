impl Solution {
    pub fn select_k_disjoint_special_substrings(s: String, k: i32) -> i32 {
        let s = s.as_bytes();
        let n = s.len();
        let k = k as usize;
        if k == 0 {
            return 0;
        }
        let mut dp = vec![vec![std::i32::MAX; k + 1]; n + 1];
        dp[0][0] = 0;
        for i in 1..=n {
            for l in 1..=k {
                if l > i {
                    continue;
                }
                let mut min_cost = std::i32::MAX;
                for j in (0..i).rev() {
                    if i - j < 3 {
                        continue;
                    }
                    if dp[j][l - 1] == std::i32::MAX {
                        continue;
                    }
                    let cost = Self::calculate_cost(&s[j..i]);
                    if cost == std::i32::MAX {
                        continue;
                    }
                    if dp[j][l - 1].saturating_add(cost) < min_cost {
                        min_cost = dp[j][l - 1].saturating_add(cost);
                    }
                }
                dp[i][l] = min_cost;
            }
        }
        if dp[n][k] == std::i32::MAX {
            -1
        } else {
            dp[n][k]
        }
    }

    fn calculate_cost(sub: &[u8]) -> i32 {
        let n = sub.len();
        if n < 3 {
            return std::i32::MAX;
        }
        let mut cost = std::i32::MAX;
        for i in 0..n - 2 {
            if sub[i] == sub[i + 1] && sub[i + 1] == sub[i + 2] {
                let current_cost = 1;
                if current_cost < cost {
                    cost = current_cost;
                }
            }
        }
        if cost != std::i32::MAX {
            return cost;
        }
        for i in 0..n - 2 {
            if sub[i] + 1 == sub[i + 1] && sub[i + 1] + 1 == sub[i + 2] {
                let current_cost = 2;
                if current_cost < cost {
                    cost = current_cost;
                }
            }
        }
        if cost != std::i32::MAX {
            return cost;
        }
        for i in 0..n - 2 {
            if sub[i] == sub[i + 2] {
                let current_cost = 3;
                if current_cost < cost {
                    cost = current_cost;
                }
            }
        }
        if cost != std::i32::MAX {
            return cost;
        }
        std::i32::MAX
    }
}
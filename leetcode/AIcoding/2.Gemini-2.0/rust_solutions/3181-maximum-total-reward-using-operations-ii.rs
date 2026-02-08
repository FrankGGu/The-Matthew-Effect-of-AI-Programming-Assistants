impl Solution {
    pub fn maximum_total_reward(rewards: Vec<i32>, ops: Vec<Vec<i32>>) -> i64 {
        let n = rewards.len();
        let mut dp = vec![vec![0; 1 << n]; ops.len() + 1];

        for i in 0..=ops.len() {
            for mask in 0..(1 << n) {
                if i == 0 {
                    let mut reward = 0;
                    for j in 0..n {
                        if (mask >> j) & 1 == 1 {
                            reward += rewards[j] as i64;
                        }
                    }
                    dp[i][mask] = reward;
                } else {
                    let op = &ops[i - 1];
                    let t = op[0] as usize;
                    let x = op[1] as usize;
                    let y = op[2] as usize;

                    dp[i][mask] = dp[i - 1][mask];

                    if t == 0 {
                        if (mask >> x) & 1 == 1 && (mask >> y) & 1 == 1 {
                            let new_mask = mask & !(1 << x) & !(1 << y);
                            dp[i][mask] = dp[i][mask].max(dp[i - 1][new_mask]);
                        }
                    } else {
                        if (mask >> x) & 1 == 0 && (mask >> y) & 1 == 0 {
                            let new_mask = mask | (1 << x) | (1 << y);
                            dp[i][mask] = dp[i][mask].max(dp[i - 1][new_mask]);
                        }
                    }
                }
            }
        }

        dp[ops.len()][(1 << n) - 1]
    }
}
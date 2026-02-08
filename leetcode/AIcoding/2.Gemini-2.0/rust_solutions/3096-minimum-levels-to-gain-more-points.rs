impl Solution {
    pub fn minimum_levels(energy: Vec<i32>) -> i32 {
        let n = energy.len();
        let mut dp = vec![i32::MAX; 1 << n];
        dp[0] = 0;

        for mask in 0..(1 << n) {
            if dp[mask] == i32::MAX {
                continue;
            }

            for i in 0..n {
                if (mask & (1 << i)) == 0 {
                    let mut cost = 0;
                    let mut current_mask = mask;
                    for j in 0..n {
                        if (current_mask & (1 << j)) != 0 {
                            cost += energy[j];
                        }
                    }
                    if cost >= energy[i] {
                        dp[mask | (1 << i)] = dp[mask | (1 << i)].min(dp[mask]);
                    } else {
                        dp[mask | (1 << i)] = dp[mask | (1 << i)].min(dp[mask] + (energy[i] - cost));
                    }
                }
            }
        }

        dp[(1 << n) - 1]
    }
}
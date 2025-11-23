impl Solution {
    pub fn connect_two_groups(cost: Vec<Vec<i32>>) -> i32 {
        let size1 = cost.len();
        let size2 = cost[0].len();
        let mut dp = vec![vec![i32::MAX; 1 << size2]; size1 + 1];
        dp[0][0] = 0;

        for i in 0..size1 {
            for mask in 0..1 << size2 {
                if dp[i][mask] == i32::MAX {
                    continue;
                }
                for j in 0..size2 {
                    let new_mask = mask | (1 << j);
                    dp[i + 1][new_mask] = dp[i + 1][new_mask].min(dp[i][mask] + cost[i][j]);
                }
            }
        }

        let mut min_cost = vec![i32::MAX; size2];
        for j in 0..size2 {
            for i in 0..size1 {
                min_cost[j] = min_cost[j].min(cost[i][j]);
            }
        }

        let mut res = i32::MAX;
        for mask in 0..1 << size2 {
            if dp[size1][mask] == i32::MAX {
                continue;
            }
            let mut total = dp[size1][mask];
            for j in 0..size2 {
                if mask & (1 << j) == 0 {
                    total += min_cost[j];
                }
            }
            res = res.min(total);
        }

        res
    }
}
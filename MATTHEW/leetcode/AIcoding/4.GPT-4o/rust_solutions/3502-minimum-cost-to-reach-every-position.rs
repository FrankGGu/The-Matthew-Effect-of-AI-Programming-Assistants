pub fn min_cost(cost: Vec<i32>, start_pos: i32, end_pos: i32, k: i32) -> i32 {
    let max_pos = cost.len() as i32;
    let mut dp = vec![i32::MAX; max_pos as usize + 1];
    dp[start_pos as usize] = 0;

    for i in 0..=k {
        let mut next_dp = dp.clone();
        for j in 0..=max_pos {
            if dp[j as usize] != i32::MAX {
                if j + 1 <= max_pos {
                    next_dp[(j + 1) as usize] = next_dp[(j + 1) as usize].min(dp[j as usize] + cost[j + 1 as usize]);
                }
                if j - 1 >= 0 {
                    next_dp[(j - 1) as usize] = next_dp[(j - 1) as usize].min(dp[j as usize] + cost[j - 1 as usize]);
                }
            }
        }
        dp = next_dp;
    }

    if dp[end_pos as usize] == i32::MAX {
        -1
    } else {
        dp[end_pos as usize]
    }
}
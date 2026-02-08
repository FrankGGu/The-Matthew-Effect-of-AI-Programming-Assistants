pub fn min_time_to_brew(p: Vec<i32>, t: Vec<i32>, total_time: i32) -> i32 {
    let n = p.len();
    let mut dp = vec![i32::MAX; (total_time + 1) as usize];
    dp[0] = 0;

    for i in 0..n {
        for j in (t[i]..=total_time).rev() {
            dp[j as usize] = dp[j as usize].min(dp[(j - t[i]) as usize] + p[i]);
        }
    }

    let mut min_cost = i32::MAX;
    for j in (0..=total_time).rev() {
        if dp[j as usize] < i32::MAX {
            min_cost = min_cost.min(dp[j as usize]);
        }
    }

    if min_cost == i32::MAX { -1 } else { min_cost }
}
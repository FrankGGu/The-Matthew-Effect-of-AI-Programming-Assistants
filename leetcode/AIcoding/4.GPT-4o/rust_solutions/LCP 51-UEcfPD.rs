pub fn cook_dishes(dishes: Vec<i32>, time_limit: i32) -> i32 {
    let mut dp = vec![0; (time_limit + 1) as usize];

    for &dish in &dishes {
        for j in (dish..=time_limit).rev() {
            dp[j as usize] = dp[j as usize].max(dp[(j - dish) as usize] + dish);
        }
    }

    dp[time_limit as usize]
}
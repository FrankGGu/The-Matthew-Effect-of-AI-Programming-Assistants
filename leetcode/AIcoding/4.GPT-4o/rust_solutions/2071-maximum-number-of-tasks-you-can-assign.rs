pub fn max_tasks(n: i32, tasks: Vec<i32>, max_time: i32) -> i32 {
    let mut dp = vec![0; (max_time + 1) as usize];
    for &task in &tasks {
        for j in (task..=max_time).rev() {
            dp[j as usize] = dp[j as usize].max(dp[(j - task) as usize] + 1);
        }
    }
    dp[max_time as usize]
}
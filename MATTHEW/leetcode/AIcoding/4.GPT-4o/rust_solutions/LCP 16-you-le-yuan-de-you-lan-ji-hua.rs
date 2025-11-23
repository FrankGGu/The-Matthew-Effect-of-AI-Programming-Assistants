pub fn max_enjoyment(n: i32, rides: Vec<Vec<i32>>) -> i32 {
    let mut dp = vec![0; n as usize + 1];

    for ride in rides {
        let (enjoyment, time) = (ride[0], ride[1]);
        for j in (time..=n).rev() {
            dp[j as usize] = dp[j as usize].max(dp[(j - time) as usize] + enjoyment);
        }
    }

    dp[n as usize]
}
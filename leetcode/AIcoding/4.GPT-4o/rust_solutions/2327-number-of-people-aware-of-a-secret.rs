pub fn num_people_aware_of_secret(n: i32, delay: i32, forget: i32) -> i32 {
    const MOD: i32 = 1_000_000_007;
    let mut dp = vec![0; n as usize + 1];
    dp[1] = 1;
    let mut total = 0;

    for i in 2..=n {
        for j in 1..=i - 1 {
            if i - j >= delay && i - j < forget {
                dp[i as usize] = (dp[i as usize] + dp[j as usize]) % MOD;
            }
        }
        if i >= forget {
            total = (total + dp[i as usize]) % MOD;
        }
    }

    total
}
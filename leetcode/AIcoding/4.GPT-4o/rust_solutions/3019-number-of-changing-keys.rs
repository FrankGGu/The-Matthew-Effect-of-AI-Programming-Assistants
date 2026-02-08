pub fn num_changing_keys(keys: Vec<i32>, target: i32) -> i32 {
    let n = keys.len();
    let mut dp = vec![0; (target + 1) as usize];
    dp[0] = 1;

    for &key in &keys {
        for j in (key..=target).rev() {
            dp[j as usize] += dp[(j - key) as usize];
        }
    }

    dp[target as usize]
}
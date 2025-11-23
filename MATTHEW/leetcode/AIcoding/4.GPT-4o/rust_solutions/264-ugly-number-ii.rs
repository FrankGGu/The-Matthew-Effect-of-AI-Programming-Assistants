pub fn nth_ugly_number(n: i32) -> i32 {
    let mut dp = vec![1; n as usize];
    let (mut i2, mut i3, mut i5) = (0, 0, 0);

    for i in 1..n as usize {
        let next_2 = dp[i2] * 2;
        let next_3 = dp[i3] * 3;
        let next_5 = dp[i5] * 5;
        dp[i] = next_2.min(next_3).min(next_5);

        if dp[i] == next_2 {
            i2 += 1;
        }
        if dp[i] == next_3 {
            i3 += 1;
        }
        if dp[i] == next_5 {
            i5 += 1;
        }
    }

    dp[(n - 1) as usize]
}
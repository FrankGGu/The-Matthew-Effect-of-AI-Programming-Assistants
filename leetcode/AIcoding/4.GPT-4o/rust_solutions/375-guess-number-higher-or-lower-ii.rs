pub fn get_money_amount(n: i32) -> i32 {
    let mut dp = vec![vec![0; n as usize + 1]; n as usize + 1];

    for length in 2..=n {
        for i in 1..=n - length + 1 {
            let j = i + length - 1;
            dp[i as usize][j as usize] = (i..=j)
                .map(|x| x + dp[i as usize][x as usize - 1] + dp[x as usize + 1][j as usize])
                .min()
                .unwrap();
        }
    }

    dp[1][n as usize]
}
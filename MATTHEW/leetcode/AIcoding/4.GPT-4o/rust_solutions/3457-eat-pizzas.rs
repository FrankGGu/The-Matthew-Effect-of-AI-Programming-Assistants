pub fn max_eaten_pizzas(pizza: Vec<Vec<i32>>, k: i32) -> i32 {
    let m = pizza.len();
    let n = pizza[0].len();
    let mut prefix_sum = vec![vec![0; n + 1]; m + 1];

    for i in (0..m).rev() {
        for j in (0..n).rev() {
            prefix_sum[i][j] = pizza[i][j] + prefix_sum[i + 1][j] + prefix_sum[i][j + 1] - prefix_sum[i + 1][j + 1];
        }
    }

    let mut dp = vec![vec![0; k as usize + 1]; m + 1];

    for i in (0..m).rev() {
        for j in (0..n).rev() {
            for l in 1..=k {
                let curr = prefix_sum[i][j];
                dp[i][l as usize] = dp[i][l as usize].max(curr + if i + 1 < m { dp[i + 1][l as usize] } else { 0 });
                if j + 1 < n {
                    dp[i][l as usize] = dp[i][l as usize].max(curr + if j + 1 < n { dp[i][l as usize - 1] } else { 0 });
                }
            }
        }
    }

    dp[0][k as usize]
}
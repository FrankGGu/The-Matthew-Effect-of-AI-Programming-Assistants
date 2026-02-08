func dieSimulator(n int, rollMax []int) int {
    const mod = 1000000007
    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, 7)
    }
    for j := 1; j <= 6; j++ {
        dp[1][j] = 1
    }

    for i := 2; i <= n; i++ {
        for j := 1; j <= 6; j++ {
            total := 0
            for k := 1; k <= 6; k++ {
                if k == j {
                    for m := 1; m <= rollMax[k-1] && i-m >= 0; m++ {
                        total += dp[i-m][k]
                        total %= mod
                    }
                } else {
                    total += dp[i-1][k]
                    total %= mod
                }
            }
            dp[i][j] = total
        }
    }

    result := 0
    for j := 1; j <= 6; j++ {
        result += dp[n][j]
        result %= mod
    }

    return result
}
func dieSimulator(n int, rollMax []int) int {
    const mod = 1e9 + 7
    dp := make([][6][16]int, n+1)

    for i := 0; i < 6; i++ {
        dp[1][i][1] = 1
    }

    for i := 2; i <= n; i++ {
        for j := 0; j < 6; j++ {
            for k := 0; k < 6; k++ {
                if j != k {
                    for l := 1; l <= rollMax[k]; l++ {
                        dp[i][j][1] = (dp[i][j][1] + dp[i-1][k][l]) % mod
                    }
                } else {
                    for l := 1; l < rollMax[j]; l++ {
                        dp[i][j][l+1] = (dp[i][j][l+1] + dp[i-1][j][l]) % mod
                    }
                }
            }
        }
    }

    res := 0
    for j := 0; j < 6; j++ {
        for l := 1; l <= rollMax[j]; l++ {
            res = (res + dp[n][j][l]) % mod
        }
    }
    return res
}
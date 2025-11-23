func dieSimulator(n int, rollMax []int) int {
    mod := int(1e9 + 7)
    dp := make([][6]int, n+1)
    for j := 0; j < 6; j++ {
        dp[1][j] = 1
    }

    for i := 2; i <= n; i++ {
        for j := 0; j < 6; j++ {
            total := 0
            for k := 0; k < 6; k++ {
                if k == j {
                    for x := 1; x <= rollMax[j] && i-x >= 0; x++ {
                        total = (total + dp[i-x][k]) % mod
                    }
                } else {
                    total = (total + dp[i-1][k]) % mod
                }
            }
            dp[i][j] = total
        }
    }

    result := 0
    for j := 0; j < 6; j++ {
        result = (result + dp[n][j]) % mod
    }

    return result
}
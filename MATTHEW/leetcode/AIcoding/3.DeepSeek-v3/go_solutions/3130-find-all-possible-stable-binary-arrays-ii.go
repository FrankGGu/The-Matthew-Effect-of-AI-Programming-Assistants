func numberOfStableArrays(zero int, one int, limit int) int {
    const mod = 1e9 + 7
    dp := make([][][2]int, zero+1)
    for i := range dp {
        dp[i] = make([][2]int, one+1)
    }
    dp[0][0][0] = 1
    dp[0][0][1] = 1

    for z := 0; z <= zero; z++ {
        for o := 0; o <= one; o++ {
            if z == 0 && o == 0 {
                continue
            }
            for k := 1; k <= limit; k++ {
                if z >= k {
                    dp[z][o][0] = (dp[z][o][0] + dp[z-k][o][1]) % mod
                }
                if o >= k {
                    dp[z][o][1] = (dp[z][o][1] + dp[z][o-k][0]) % mod
                }
            }
        }
    }

    return (dp[zero][one][0] + dp[zero][one][1]) % mod
}
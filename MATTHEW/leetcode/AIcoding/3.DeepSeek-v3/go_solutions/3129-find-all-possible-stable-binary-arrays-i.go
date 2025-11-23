func stableBinaryArrays(zero int, one int, limit int) []int {
    mod := int(1e9 + 7)
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
            if z > 0 {
                dp[z][o][0] = dp[z-1][o][1]
                if z > limit {
                    dp[z][o][0] = (dp[z][o][0] - dp[z-limit-1][o][1] + mod) % mod
                }
            }
            if o > 0 {
                dp[z][o][1] = dp[z][o-1][0]
                if o > limit {
                    dp[z][o][1] = (dp[z][o][1] - dp[z][o-limit-1][0] + mod) % mod
                }
            }
        }
    }
    res := (dp[zero][one][0] + dp[zero][one][1]) % mod
    return []int{res}
}
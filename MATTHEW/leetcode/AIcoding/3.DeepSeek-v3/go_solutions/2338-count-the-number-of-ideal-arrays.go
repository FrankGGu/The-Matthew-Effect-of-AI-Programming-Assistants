func idealArrays(n int, maxValue int) int {
    mod := int(1e9 + 7)

    maxK := 20
    comb := make([][]int, n)
    for i := range comb {
        comb[i] = make([]int, maxK)
    }
    comb[0][0] = 1
    for i := 1; i < n; i++ {
        comb[i][0] = 1
        for j := 1; j < maxK; j++ {
            comb[i][j] = (comb[i-1][j-1] + comb[i-1][j]) % mod
        }
    }

    dp := make([][]int, maxValue+1)
    for i := range dp {
        dp[i] = make([]int, maxK)
    }
    for i := 1; i <= maxValue; i++ {
        dp[i][1] = 1
    }

    for k := 1; k < maxK; k++ {
        for i := 1; i <= maxValue; i++ {
            for m := 2 * i; m <= maxValue; m += i {
                dp[m][k+1] = (dp[m][k+1] + dp[i][k]) % mod
            }
        }
    }

    res := 0
    for i := 1; i <= maxValue; i++ {
        for k := 1; k < maxK; k++ {
            if dp[i][k] == 0 {
                continue
            }
            ways := comb[n-1][k-1]
            res = (res + dp[i][k] * ways % mod) % mod
        }
    }
    return res
}
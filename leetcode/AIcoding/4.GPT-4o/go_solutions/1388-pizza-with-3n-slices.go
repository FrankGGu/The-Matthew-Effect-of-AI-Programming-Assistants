func maxSizeSlices(slices []int, n int) int {
    k := len(slices) / 3
    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, k+1)
    }

    for j := 0; j < 2; j++ {
        for i := 1; i <= n; i++ {
            for l := k; l >= 1; l-- {
                for m := len(slices) - 1 - j*(k-1); m >= j*k; m-- {
                    dp[i][l] = max(dp[i][l], dp[i-1][l-1]+slices[m])
                }
            }
        }
    }

    return dp[n][k]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}
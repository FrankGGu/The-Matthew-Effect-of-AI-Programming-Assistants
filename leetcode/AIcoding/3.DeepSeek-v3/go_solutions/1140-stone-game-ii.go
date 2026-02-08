func stoneGameII(piles []int) int {
    n := len(piles)
    dp := make([][]int, n)
    for i := range dp {
        dp[i] = make([]int, n+1)
    }
    suffixSum := make([]int, n+1)
    for i := n - 1; i >= 0; i-- {
        suffixSum[i] = suffixSum[i+1] + piles[i]
    }
    for i := n - 1; i >= 0; i-- {
        for m := 1; m <= n; m++ {
            if i + 2 * m >= n {
                dp[i][m] = suffixSum[i]
            } else {
                maxVal := 0
                for x := 1; x <= 2 * m; x++ {
                    nextM := max(x, m)
                    if i + x > n {
                        continue
                    }
                    current := suffixSum[i] - dp[i+x][nextM]
                    if current > maxVal {
                        maxVal = current
                    }
                }
                dp[i][m] = maxVal
            }
        }
    }
    return dp[0][1]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}
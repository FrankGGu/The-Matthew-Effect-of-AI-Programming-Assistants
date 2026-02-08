package main

func stoneGameII(piles []int) int {
    n := len(piles)
    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, n+1)
    }
    for i := n - 1; i >= 0; i-- {
        for j := 1; j <= n; j++ {
            if i == n-1 {
                dp[i][j] = piles[i]
            } else {
                maxVal := 0
                for k := 1; k <= 2*j && i+k < n; k++ {
                    next := dp[i+k][max(j, k)]
                    maxVal = max(maxVal, sumPiles(i, i+k-1, piles)-next)
                }
                dp[i][j] = maxVal
            }
        }
    }
    return dp[0][1]
}

func sumPiles(start, end int, piles []int) int {
    res := 0
    for i := start; i <= end; i++ {
        res += piles[i]
    }
    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}
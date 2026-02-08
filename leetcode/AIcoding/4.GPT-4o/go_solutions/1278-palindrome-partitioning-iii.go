func palindromePartitioningIII(s string, k int) int {
    n := len(s)
    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, n+1)
    }

    for i := 0; i <= n; i++ {
        for j := 0; j <= n; j++ {
            if i == j {
                dp[i][j] = 0
            } else {
                dp[i][j] = dp[i][j-1]
                for l := i; l < j; l++ {
                    if s[l] != s[j-1] {
                        dp[i][j]++
                    }
                }
            }
        }
    }

    minCuts := make([]int, k+1)
    for i := 1; i <= k; i++ {
        minCuts[i] = math.MaxInt32
    }

    for i := 1; i <= n; i++ {
        for j := 1; j <= i && j <= k; j++ {
            if j == 1 {
                minCuts[j] = dp[0][i]
            } else {
                minCuts[j] = min(minCuts[j], minCuts[j-1]+dp[i-1][i])
            }
        }
    }

    return minCuts[k]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}
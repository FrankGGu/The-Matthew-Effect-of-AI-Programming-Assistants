func findLength(A []int, B []int) int {
    m, n := len(A), len(B)
    dp := make([][]int, m+1)
    for i := range dp {
        dp[i] = make([]int, n+1)
    }
    maxLen := 0
    for i := 1; i <= m; i++ {
        for j := 1; j <= n; j++ {
            if A[i-1] == B[j-1] {
                dp[i][j] = dp[i-1][j-1] + 1
                if dp[i][j] > maxLen {
                    maxLen = dp[i][j]
                }
            }
        }
    }
    return maxLen
}
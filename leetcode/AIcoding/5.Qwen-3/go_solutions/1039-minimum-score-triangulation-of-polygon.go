package main

func minScoreTriangulation(polygon []int) int {
    n := len(polygon)
    dp := make([][]int, n)
    for i := range dp {
        dp[i] = make([]int, n)
    }

    for length := 2; length < n; length++ {
        for i := 0; i < n-length; i++ {
            j := i + length
            dp[i][j] = math.MaxInt32
            for k := i + 1; k < j; k++ {
                dp[i][j] = min(dp[i][j], dp[i][k]+dp[k][j]+polygon[i]*polygon[k]*polygon[j])
            }
        }
    }

    return dp[0][n-1]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}